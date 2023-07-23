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
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedIndex) {
                    ForEach($myCards.indices) { index in
                        Button(action: {isDetail.toggle()}){
                            CardView(card: $myCards[index])
                        }
                        .tag(index)
                        .navigationDestination(isPresented: $isDetail) {
                            ProfileDetailView(profileCard: $myCards[index], isFromMy: true)
                        }
                    }
                }
                .border(.red)
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
        }
    }
}

struct MyCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsView(myCards: .constant(ProfileCardModel.sampleData))
    }
}
