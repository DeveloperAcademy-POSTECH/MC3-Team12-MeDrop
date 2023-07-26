//
//  MyCardsView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/22.
//

import SwiftUI

struct MyCardsView: View {
    @Binding var myCards: [ProfileCardModel]
    @State private var newCard = ProfileCardModel.emptyCard
    @State var selectedIndex = 0
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State var isMenu = false
    @State var isDetail = false
    @State var isCreate = false
    
    let saveAction: () -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedIndex) {
                    ForEach($myCards.indices, id: \.self) { index in
                        Button(action: {isDetail.toggle()}) {
                            CardView(card: $myCards[index])
                        }
                        .tag(index)
                        .navigationDestination(isPresented: $isDetail) {
                            CardDetailMyView(card: $myCards[index])
                        }
                    }
                    
                    if $myCards.count == 5 {
                        FinalCardView()
                            .tag($myCards.count + 1)
                    } else {
                        Button(action: {isCreate.toggle()}) {
                            PlusCardView()
                        }
                        .tag($myCards.count + 1)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .navigationTitle("MY CARDS")
            .toolbar {
                Button(action: { isMenu.toggle() }) {
                    Image(systemName: "ellipsis")
                }
                .navigationDestination(isPresented: $isMenu) {
                    MenuView()
                }
            }
            .sheet(isPresented: $isCreate) {
                NewCardView(cards: $myCards, isFinish: $isCreate)
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct MyCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsView(myCards: .constant(ProfileCardModel.sampleData), saveAction: {})
    }
}
