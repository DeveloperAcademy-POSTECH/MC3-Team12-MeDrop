//
//  YourCardTest.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/12.
//

import SwiftUI

struct YourCardTest: View {
    @State var cards: [ProfileCardModel]
    var body: some View {
        NavigationView {
            VStack {
                ForEach($cards) {  $card in
                    NavigationLink(destination: ProfileDetailView2(profileCard: $card, isFromMy: false)) {
                        Text(card.name)
                    }
                }
            }
        }
    }
}

struct YourCardTest_Previews: PreviewProvider {
    static var previews: some View {
        YourCardTest(cards: ProfileCardModel.sampleData)
    }
}
