//
//  ContentView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mpc = MpcManager(userName: "HKKKSSS", cardId: "12345\(UIDevice.current.name)")
    
   
    var body: some View {
        VStack {
            Button("Start") {
                mpc.startHosting()
            }
            
            Button("Stop") {
                mpc.invalidate()
            }
            Text(mpc.receiveCard)
        
            if !mpc.connectedPeers.isEmpty {
                
                List(mpc.connectedPeers, id: \.self){ peer in
                    Text(peer.displayName)
                        .onTapGesture {
                            DEBUG_LOG("TAP")
                            mpc.sendData(peer: peer)
                        }
                }
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
