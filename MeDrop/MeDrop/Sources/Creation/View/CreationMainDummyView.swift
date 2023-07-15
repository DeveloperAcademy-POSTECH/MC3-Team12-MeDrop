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
    
    @State var profileCard: ProfileCardModel = ProfileCardModel()
    @State var sheetTitle: String = "프로필 만들기"
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationStack {
            Button("create new one") {
                isShowingSheet.toggle()
            }
        }.sheet(isPresented: $isShowingSheet) {
            CreateInfoView(isShowingSheet: $isShowingSheet, profileCard: $profileCard, sheetTitle: $sheetTitle).environmentObject(myCards)
        }
    }
}

struct CreationMainDummyView_Previews: PreviewProvider {
    static var previews: some View {
        CreationMainDummyView()
    }
}
