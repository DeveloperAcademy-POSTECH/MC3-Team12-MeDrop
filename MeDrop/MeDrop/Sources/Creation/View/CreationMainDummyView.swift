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
    
    var body: some View {
        NavigationStack {
            NavigationLink("New Card", destination: CreateInfoView())
                .environmentObject(myCards)
        }
    }
}

struct CreationMainDummyView_Previews: PreviewProvider {
    static var previews: some View {
        CreationMainDummyView()
    }
}
