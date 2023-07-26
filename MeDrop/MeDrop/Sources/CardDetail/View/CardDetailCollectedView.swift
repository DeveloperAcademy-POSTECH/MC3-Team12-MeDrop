//
//  CardDetailCollectedView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct CardDetailCollectedView: View {
    @Binding var card: ProfileCardModel
    var body: some View {
        CardDetailView(card: $card, isFromMy: false)
    }
}

struct CardDetailCollectedView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailCollectedView(card: .constant(ProfileCardModel.sampleData[1]))
    }
}
