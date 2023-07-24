//
//  NearByManager.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import SwiftUI
import MultipeerConnectivity
import Combine

enum ConnectState: Codable { // 연결 상태
    case connected
    case notConnected
}

enum RequestType: Codable { // mpc 요청 타입
    case connect
    case confirm
    case denied
}

struct MpcInfoDTO: Codable { // mpc에 실어 보낼 데이터 타입
    let type: RequestType
    let peerId: String
    let cardInfo: String
    let userName: String
}

class MpcManager: NSObject, ObservableObject {
    private let mcSession: MCSession
    private let localPeerID: MCPeerID
    private let mcAdvertiser: MCNearbyServiceAdvertiser
    private let mcBrowser: MCNearbyServiceBrowser
    private let identityString: String
    private let maxNumPeers: Int // 최대 연결 가능한 피어 수
    private let card: String
    private let serviceType: String = "medrop" // Bonjour Service 아이디에서 _  _.tcp 제거한 값
    
    private var subscriptions = Set<AnyCancellable>()
    var selectedPeer: MCPeerID?
    var userName: String
    var connectedUser: String = ""
    
    @Published var connectedPeers: [MCPeerID] = [] // 현재 연결된 피어
    @Published var receiveCard: String = ""
    @Published var connectedState: ConnectState = .notConnected
    @Published var alertUserName:String = "" // 알람에 보여줄 이름
    @Published var showPermissionAlert:Bool = false // 알람 플래그 변수
    
    
    init(userName: String, cardId: String, maxPeers: Int = 5) {
        
        self.maxNumPeers = maxPeers
        self.identityString = UUID().uuidString //TODO: PreferenceManager.id ?? ""
        self.userName = userName
        self.card = cardId
        self.localPeerID = MCPeerID(displayName: identityString)
        
        self.mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .none)
        
        self.mcAdvertiser = MCNearbyServiceAdvertiser(peer: localPeerID, discoveryInfo: nil, serviceType: serviceType)
        self.mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceType)
        
        super.init()
        mcSession.delegate = self
        mcAdvertiser.delegate = self
        mcBrowser.delegate = self
    }
    
    deinit {
        invalidate()
        DEBUG_LOG("DEINIT: MpcManager")
    }
}

extension MpcManager {
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
    
    
    
    public func sendDeniedState() { // 거절 신호 보내기
        guard let peer = selectedPeer else  {
            return
        }
        
        sendData(peer: peer, data: MpcInfoDTO(type: .denied, peerId: identityString, cardInfo: "", userName: ""))
        disConnecting() // 이전 연결 삭제
    }
    
    public func confirmConnectState(id: String) { //확인 신호 보내기
        
        let peer = findPeerWIthId(id: id)
        
        sendData(peer: peer, data: MpcInfoDTO(type: .confirm, peerId: identityString, cardInfo: "", userName: userName))
    }
    
    public func sendConnectState() { //연결 신호 보내기
        guard let peer = selectedPeer else {
            return
        }
        
        sendData(peer: peer, data: MpcInfoDTO(type: .connect, peerId: identityString, cardInfo: card ,userName: userName ))
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
        self.connectedState = .notConnected
        self.receiveCard = ""
        self.connectedUser = ""
        self.alertUserName = ""
    }
    
    private func sendData(peer: MCPeerID, data: MpcInfoDTO) {
        DEBUG_LOG("SEND")
        if !mcSession.connectedPeers.isEmpty{
            do {
                let encodeData = try JSONEncoder().encode(data)
                try mcSession.send(encodeData, toPeers: [peer], with: .reliable)
            } catch let error as NSError {
                DEBUG_LOG(error.localizedDescription)
            }
        }
    }
}

extension MpcManager: MCSessionDelegate {
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
        case .connect: //연결 신호 일때
            
            if connectedState == .notConnected { // 아직 연결 안되었을 때
                DispatchQueue.main.async { [weak self] in
                    guard let self else {return}
                    self.selectedPeer = peerID
                    self.connectedState = .connected
                    self.receiveCard = receiveData.cardInfo
                    self.connectedUser = receiveData.userName
                    self.sendConnectState() // 연결한 피어로 연결신호 재전송
                }
            }
        
        case .confirm:
            
            DEBUG_LOG("CONFIRM")
            
            if selectedPeer == nil { //
                DispatchQueue.main.async { [weak self] in
                    guard let self else {return}
                
                    //얼럿 띠우기
                    self.alertUserName = receiveData.userName
                    self.showPermissionAlert.toggle()
                    self.selectedPeer = peerID
                }
            }
            
           
                
            
            
        case .denied:
        
            // 거절 신호 보내기
            if self.connectedState != .notConnected {
                DispatchQueue.main.async { [weak self] in
                    guard let self else {return}
                    
                    self.disConnecting()
                    self.sendDeniedState()
                }
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

extension MpcManager: MCNearbyServiceBrowserDelegate {
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

extension MpcManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        DEBUG_LOG("CONNECT \(mcSession.connectedPeers.count) ")
        
        if mcSession.connectedPeers.count < maxNumPeers {
            invitationHandler(true, mcSession)
        }
            
    }
}
