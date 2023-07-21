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
            Button("Button") {
                mpc.startHosting()
            }
            Text(mpc.receiveCard)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
