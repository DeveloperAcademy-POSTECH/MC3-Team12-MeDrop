//
//  NearByManager.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import SwiftUI
import MultipeerConnectivity
import Combine

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
    
    @Published var connectedPeers: [MCPeerID] = [] // 현재 연결된 피어 
    @Published var receiveCard:String = ""
    @Published var isPermission:Bool = false
    @Published var showPermission:Bool = false
    
    
    init(userName: String, cardId: String, maxPeers: Int = 1) {
        self.maxNumPeers = maxPeers
        self.identityString = PreferenceManager.id ?? ""
        
        self.card = cardId
        self.localPeerID = MCPeerID(displayName: userName)
        
        self.mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .none)
        
        self.mcAdvertiser = MCNearbyServiceAdvertiser(peer: localPeerID, discoveryInfo: nil, serviceType: serviceType)
        self.mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceType)
        
     
        super.init()
        mcSession.delegate = self
        mcAdvertiser.delegate = self
        mcBrowser.delegate = self
        bind()
        
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
        mcSession.disconnect()
    }
    
    func sendData() {
        DEBUG_LOG("SEND")
        if !mcSession.connectedPeers.isEmpty {
            guard let cardData = card.data(using: .utf8) else {
                return
            }
            
            do {
                try mcSession.send(cardData, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch let error as NSError {
                DEBUG_LOG(error.localizedDescription)
            }
        }
    }
    
    func bind() {
        $receiveCard
            .filter({!$0.isEmpty})
            .sink { [weak self] _ in
            guard let self else {return}
            
            self.showPermission.toggle()
        }
        .store(in: &subscriptions)
        
        $connectedPeers.sink { peers in
            DEBUG_LOG(peers.count)
        }
        .store(in: &subscriptions)
    }
}

extension MpcManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DEBUG_LOG("제발1")
        
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
                self.sendData()
            }
            
        @unknown default:
            DEBUG_LOG("Unkwon Error")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // 데이터 전달 받음
        
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            
            guard let str = String(data: data, encoding: .utf8) else {
                return
            }
            self.receiveCard = str
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
        browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    }
}

extension MpcManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
            invitationHandler(true, mcSession)
    }
}
