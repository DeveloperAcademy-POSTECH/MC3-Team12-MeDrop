//
//  CreationMainDummyView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import SwiftUI

struct CreationMainDummyView: View {
    // Get mycards and yourcards containing card num by reqeusting with userID
    @StateObject var myCards = EnvironmentData()
    @StateObject var yourCards = EnvironmentData()
    
    @State var showingCreation = false
    
    var body: some View {
        NavigationStack {
            Button("create new one") {
                showingCreation = true
            }
        }.sheet(isPresented: $showingCreation) {
            CreateInfoView(showingCreation: $showingCreation).environmentObject(myCards)
        }
    }
}

struct CreationMainDummyView_Previews: PreviewProvider {
    static var previews: some View {
        CreationMainDummyView()
    }
}
