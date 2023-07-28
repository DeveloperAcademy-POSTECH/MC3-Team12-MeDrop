//
//  MainView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel = .init()
    @StateObject private var cardStore = CardStore()
    @State var tab: MainViewTab = .my
    
    var body: some View {
        ZStack {
            if !viewModel.isSplashFinished {
                LottieView(jsonName: "MEDROP") { _ in
                    withAnimation {
                        viewModel.isSplashFinished.toggle()
                    }
            }
            } else if viewModel.isSplashFinished && viewModel.id == nil {
                OnBoardView()
            } else {
                TabView(selection: $tab) {
                    MyCardsView(myCards: $cardStore.myCards) {
                        Task {
                            try await cardStore.saveData()
                        }
                    }
                        .tabItem {
                            Label("My", systemImage: "person.crop.circle.fill")
                        }
                        .tag(MainViewTab.my)
                    
                    ExchangeView()
                        .tabItem {
                            Label("Exchange", systemImage: "arrow.up.arrow.down.circle.fill")
                        }
                        .tag(MainViewTab.exchange)
                    
                    CollectedCardsView(yourCards: $cardStore.yourCards){
                        Task {
                            try await cardStore.saveData()
                        }
                    }
                        .tabItem {
                            Label("Collect", systemImage: "shared.with.you")
                        }
                        .tag(MainViewTab.collection)
                }
                .task {
                    do {
                        try await cardStore.loadData()

                    } catch {
                        print("load Error")
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

enum MainViewTab: Hashable {
    case my
    case exchange
    case collection
}
