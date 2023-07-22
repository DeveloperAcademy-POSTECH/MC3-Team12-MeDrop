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
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedIndex) {
                    ForEach($myCards.indices) { index in
                        CardView(card: $myCards[index])
                            .tag(index)
                    }
                }
                .border(.red)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .navigationTitle("My Cards")
            .toolbar {
                Button(action:{ isMenu.toggle() }){
                    Image(systemName: "ellipsis")
                }
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
