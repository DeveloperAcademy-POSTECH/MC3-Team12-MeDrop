//
//  CreateCardInfoView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI

struct CreateCardView: View {
    @State var navigationControl: Int = 0
    @State var card: ProfileCardModel = ProfileCardModel()
    @Binding var cards: [ProfileCardModel]
    
    var body: some View {
        ZStack {
            if navigationControl == 0 {
                EnterInfo1View(navigationControl: $navigationControl, card: $card)
            } else if navigationControl == 1 {
                EnterInfo2View(navigationControl: $navigationControl, card: $card)
            } else {
                EnterDesignView(navigationControl: $navigationControl, card: $card, cards: $cards)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct CreateCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCardView(cards: .constant(ProfileCardModel.sampleData))
    }
}
