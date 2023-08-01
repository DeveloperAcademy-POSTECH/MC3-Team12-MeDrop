//
//  CreateCardInfoView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI

struct CreateCardView: View {
    @State var navigationControl: Int = 0
    @Binding var editingCard: ProfileCardModel
    @Binding var originCard: ProfileCardModel
    @Binding var cards: [ProfileCardModel]
    var isCreate: Bool
    
    var body: some View {
        ZStack {
            if navigationControl == 0 {
                EnterInfo1View(navigationControl: $navigationControl, editingCard: $editingCard, originCard: $originCard)
            } else if navigationControl == 1 {
                EnterInfo2View(navigationControl: $navigationControl, editingCard: $editingCard, originCard: $originCard)
            } else {
                EnterDesignView(navigationControl: $navigationControl, editingCard: $editingCard, originCard: $originCard, cards: $cards, isCreate: isCreate)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct CreateCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCardView(editingCard: .constant(ProfileCardModel.emptyCard), originCard: .constant(ProfileCardModel.emptyCard), cards: .constant( ProfileCardModel.sampleData), isCreate: true)
    }
}
