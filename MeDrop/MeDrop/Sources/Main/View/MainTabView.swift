//
//  MainTabView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/30.
//

import SwiftUI

struct MainTabView: View {
        @State var selectedTab: Tab = .my
        @State var showingAlert = false
    @State var tempCards: [ProfileCardModel] = [ ProfileCardModel(name: "젤리빈", contact: "010-0000-0000", company: "􀣺 jelly Developer Academy", job: "Designer.", introduction: "한 줄 소개; 젤리빈 어쩌구 저쩌구", email: "jellyBeen@gmail.com", link: "jellyBeen.com", designType: "0-0", date: 20200102),
                                                 ProfileCardModel(name: "릴리", contact: "010-1111-1111", company: "􀣺 lily Academy", job: "Developer.", introduction: "한 줄 소개; 릴리 개발자", email: "lily@gmail.com", link: "lily.com", insta: "@seooo_02", designType: "0-1", date: 20200103),
                                                 ProfileCardModel(name: "호제", contact: "010-2222-2222", company: "􀣺 hoje Developer ", job: "CEO.", introduction: "한 줄 소개; 호제 CEO", email: "hoje@gmail.com", link: "hoje.com", designType: "1-2", date: 20200104)]
    
        @StateObject private var cardStore = CardStore()
        
        var body: some View {
            ZStack {
                VStack {
                    Group {
                        switch selectedTab {
                        case .my:
                            MyCardsView(selectedTab: $selectedTab, myCards: $cardStore.myCards) {
                                Task {
                                    try await cardStore.saveData()
                                }
                            }
                        case .your:
                            CollectedCardsView(selectedTab: $selectedTab, yourCards:
                                                $tempCards
                                                //                                                $cardStore.yourCards
                            ){
                                Task {
                                    try await cardStore.saveData()
                                }
                            }
                        case .exchange:
                            ExchangeView(card:ProfileCardModel.sampleData[1],tab: $selectedTab) //TODO: 선택된 카드로 넣기
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.clear)
                .ignoresSafeArea()
                
            }.task {
                do {
                    try await cardStore.loadData()
                } catch {
                    print("load Error")
                }
            }
        }
    }

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
