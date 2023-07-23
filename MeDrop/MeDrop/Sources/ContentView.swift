//
//  ContentView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mpc = MpcManager(userName: "H", cardId: "12345\(UIDevice.current.name)")
    
   
    var body: some View {
        VStack {
            Button("Start") {
                mpc.startHosting()
            }
            
            Button("Stop") {
                mpc.invalidate()
            }
            Text(mpc.receiveCard)
        }
        .alert(isPresented: $mpc.showPermission) {
            Alert(title: Text("\(mpc.receiveCard) 가 맞나요?"), primaryButton: .default(Text("YES"),action: {
                DEBUG_LOG("GET")
            }), secondaryButton: .destructive(Text("NO")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
