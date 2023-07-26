//
//  ContentView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mpc = MpcManager(data: ShareData(userName: "ㅈㄷㅂㄷ", team: "소속2",cardInfo: "hhh",image: "Image1"))
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
                            mpc.confirmConnectState(id: peer.displayName)
                        }
                }
            }
        }
        .alert(isPresented: $mpc.showPermissionAlert) {
            Alert(title: Text("\(mpc.alertUserName)이 맞습니까?"), primaryButton: .default(Text("YES"),action: {
                mpc.sendConnectState()
            }), secondaryButton: .destructive(Text("NO"), action: {
                mpc.sendDeniedState()
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
