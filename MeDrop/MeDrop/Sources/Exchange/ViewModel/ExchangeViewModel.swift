//
//  NearByManager.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import SwiftUI
import MultipeerConnectivity
import Combine

enum ExchangeState{
    case request
    case waiting
    case exchange
    case none
}

class ExchangeViewModel: NSObject, ObservableObject {
    private let mcSession: MCSession
    private let localPeerID: MCPeerID
    private let mcAdvertiser: MCNearbyServiceAdvertiser
    private let mcBrowser: MCNearbyServiceBrowser
    private let identityString: String
    private let maxNumPeers: Int // 최대 연결 가능한 피어 수
    private let serviceType: String = "medrop" // Bonjour Service 아이디에서 _  _.tcp 제거한 값
    
    private var subscriptions = Set<AnyCancellable>()
    var selectedPeer: MCPeerID?
    var data: ProfileCardModel
    var connectedUser: String = ""
    
    @Published var connectedPeers: [MCPeerID] = [] // 현재 연결된 피어
    @Published var receiveCard: ProfileCardModel = ProfileCardModel()
    @Published var alertUserName: String = "" // 알람에 보여줄 이름
    @Published var showAlert: Bool = false // 알람 플래그 변수
    @Published var state: ExchangeState = .none
    @Published var toast: Toast?
    
    init(data: ProfileCardModel, maxPeers: Int = 5) {
        
        self.maxNumPeers = maxPeers
        self.data = data
        self.identityString = "\(data.name)\(seperatorString)\(data.company)\(seperatorString)\(data.job)\(seperatorString)"
        self.localPeerID = MCPeerID(displayName: identityString)
        
        self.mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .none)
        
        self.mcAdvertiser = MCNearbyServiceAdvertiser(peer: localPeerID, discoveryInfo: nil, serviceType: serviceType)
        self.mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceType)
           
        super.init()
        mcSession.delegate = self
        mcAdvertiser.delegate = self
        mcBrowser.delegate = self
        
        startHosting()
    }
    
    deinit {
        invalidate()
        DEBUG_LOG("DEINIT: MpcManager")
    }
}

extension ExchangeViewModel {
    func startHosting() {
        DEBUG_LOG("START")
        mcAdvertiser.startAdvertisingPeer()
        mcBrowser.startBrowsingForPeers()
    }
    
    func stopHosting() {
        mcAdvertiser.stopAdvertisingPeer()
        mcBrowser.stopBrowsingForPeers()
    }
    
    func invalidate() {
        stopHosting()
        disConnecting()
        mcSession.disconnect()
    }
    
    
    public func sendOccupiedState(peer:MCPeerID) { // 이미 사용중 신호 보내기
        
        sendData(peer: peer, data: MpcInfoDTO(type: .occupied, peerId: identityString, data: data ))
    }
    
    public func sendDeniedState() { // 거절 신호 보내기
        
        self.state = .none
        
        guard let peer = selectedPeer else  {
            return
        }
        
        sendData(peer: peer, data: MpcInfoDTO(type: .denied, peerId: identityString, data: data ))
        disConnecting() // 이전 연결 삭제
    }
    
    public func confirmConnectState(id: String) { //확인 신호 보내기
        
        self.state = .waiting
        let peer = findPeerWIthId(id: id)
        
        sendData(peer: peer, data: MpcInfoDTO(type: .confirm, peerId: identityString, data: data))
    }
    
    public func sendConnectState() { //연결 신호 보내기
        
        
       
        
        guard let peer = selectedPeer else {
            return
        }
        
        sendData(peer: peer, data: MpcInfoDTO(type: .connect, peerId: identityString, data: data))
    }
    
    private func findPeerWIthId(id: String) -> MCPeerID { // id 값을 통해 PeerID 찾기
        
        var peer =  MCPeerID(displayName: UUID().uuidString)
        
        for cpeer in connectedPeers {
            if cpeer.displayName == id {
                peer = cpeer
                break
            }
        }
        
        return peer
    }
    
    private func disConnecting() {
        self.selectedPeer = nil
        self.receiveCard = ProfileCardModel()
        self.connectedUser = ""
        self.alertUserName = ""
        self.state = .none
    }
    
    private func sendData(peer: MCPeerID, data: MpcInfoDTO) {
        if !mcSession.connectedPeers.isEmpty{
            do {
                let encodeData = try JSONEncoder().encode(data)
                try mcSession.send(encodeData, toPeers: [peer], with: .reliable)
            } catch let error as NSError {
                DEBUG_LOG(error.localizedDescription)
            }
        }
    }
    
    public func save(){
        var container = PreferenceManager.collections
        container?.append(receiveCard)
        PreferenceManager.collections = container
        disConnecting()
    }
}

extension ExchangeViewModel: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            DEBUG_LOG("Seesion Not Connected")
        
        case .connecting:
            DEBUG_LOG("Seesion Connecteing")
        
        case .connected:
            DEBUG_LOG("Seesion Connected")
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.connectedPeers = session.connectedPeers
                self.connectedPeers = self.connectedPeers.uniqued() // 중복제거
            }
            
        @unknown default:
            DEBUG_LOG("Unkwon Error")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // 데이터 전달 받음
        
        guard let receiveData = try? JSONDecoder().decode(MpcInfoDTO.self, from: data) else {
            return
        }
        
        
        switch receiveData.type {
        case .connect: // 연결 신호 일때
            
            
            if state != .exchange { // 아직 연결 안되었을 때
                DispatchQueue.main.async { [weak self] in
                    guard let self else {return}
                    self.selectedPeer = peerID
                    self.receiveCard = receiveData.data
                    self.connectedUser = receiveData.data.name
                    self.state = .exchange
                    self.sendConnectState() // 연결한 피어로 연결신호 재전송
                }
            }
            
        case .confirm:
        
            
            if selectedPeer == nil && state != .request && state != .waiting { // 연결이 아무도 안되었을 때
                DispatchQueue.main.async { [weak self] in
                    guard let self else {return}
                    
                    //얼럿 띠우기
                    self.alertUserName = receiveData.data.name
                    self.selectedPeer = peerID
                    self.state = .request
                }
            }
            
            else { // 연결된 상태로 다른 요청이 왔을 때
                sendOccupiedState(peer: peerID)
            }
            
            
        case .denied:
            
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                
                self.toast = Toast(type: .exchange, title: "ME DROP", message: "상대방이 교환 요청을 거절하셨습니다.")
                self.disConnecting()
                
            }
    
            
        case .occupied:
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                
                self.toast = Toast(type: .exchange, title: "거절 알림", message: "상대방이 교환을 진행 중이에요.")
                self.disConnecting()
                
            }
            
            
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
       
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
 
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}

extension ExchangeViewModel: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        // 세션 초대 
        
        DEBUG_LOG("CONNECT \(mcSession.connectedPeers.count) ")
        if mcSession.connectedPeers.count < maxNumPeers {
            browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 10)
        }
        
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }
}

extension ExchangeViewModel: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        
        if mcSession.connectedPeers.count < maxNumPeers {
            invitationHandler(true, mcSession)
        }
            
    }
}

