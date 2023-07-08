//
//  ContentView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("10")
        }
        .padding()
        .onAppear{
            FireBaseDataBaseManager.shared
                .child("firest")
                .observeSingleEvent(of: .value) { snapshot in
                    print("SnapShot")
                   
                    guard let value = snapshot.value as? String else {
                        print("RET")
                        return
                    }
                    print(value)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
