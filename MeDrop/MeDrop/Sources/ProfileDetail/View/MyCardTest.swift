//
//  MyCardTest.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/12.
//

import SwiftUI

struct MyCardTest: View {
    @State var cards: [ProfileCardModel]
    var body: some View {
        NavigationView {
            VStack {
                ForEach($cards) {  $card in
                    NavigationLink(destination: ProfileDetailView(profileCard: $card, isFromMy: true)) {
                        Text(card.name)
                    }
                }
            }
        }
        .onAppear{
            loadUserData()
        }
    }
}

struct MyCardTest_Previews: PreviewProvider {
    static var previews: some View {
        MyCardTest(cards: ProfileCardModel.sampleData)
    }
}