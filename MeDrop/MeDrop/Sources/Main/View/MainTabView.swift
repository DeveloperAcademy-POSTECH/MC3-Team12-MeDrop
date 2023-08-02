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
    
        @State var selectedIndex: Int = 0
    
        @StateObject private var cardStore = CardStore()
        
        var body: some View {
            ZStack {
                VStack {
                    Group {
                        switch selectedTab {
                        case .my:
                            MyCardsView(selectedTab: $selectedTab, myCards: $cardStore.myCards, selectedIndex: $selectedIndex ) {
                                Task {
                                    try await cardStore.saveData()
                                }
                            }
                        case .your:
                            CollectedCardsView(selectedTab: $selectedTab, yourCards: $cardStore.yourCards
                            ){
                                Task {
                                    try await cardStore.saveData()
                                }
                            }
                        case .exchange:
                            ExchangeView(card: cardStore.myCards[selectedIndex],tab: $selectedTab)
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
