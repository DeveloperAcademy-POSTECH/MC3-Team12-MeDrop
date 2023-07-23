//
//  MyCardsView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/22.
//

import SwiftUI

struct MyCardsView: View {
    @Binding var myCards: [ProfileCardModel]
    @State var selectedIndex = 0
    
    @State var isMenu = false
    @State var isDetail = false
    @State var isCreate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedIndex) {
                    ForEach($myCards.indices) { index in
                        Button(action: {isDetail.toggle()}) {
                            CardView(card: $myCards[index])
                        }
                        .tag(index)
                        .navigationDestination(isPresented: $isDetail) {
                            CardDetailView(card: $myCards[index], isFromMy: true)
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
            .navigationTitle("My Cards")
            .toolbar {
                Button(action: { isMenu.toggle() })
                { Image(systemName: "ellipsis") }
                .navigationDestination(isPresented: $isMenu) {
                    MenuView()
                }
            }
            .sheet(isPresented: $isCreate){
                
            }
        }
    }
}

struct MyCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsView(myCards: .constant(ProfileCardModel.sampleData))
    }
}
