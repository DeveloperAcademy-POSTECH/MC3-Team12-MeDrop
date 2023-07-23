//
//  CardDetailMyView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct CardDetailMyView: View {
    @Binding var card: ProfileCardModel
    var body: some View {
        CardDetailView(card: $card, isFromMy: true)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("편집") {
                        
                    }
                }
            }
    }
}

struct CardDetailMyView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailMyView(card: .constant(ProfileCardModel.sampleData[1]))
    }
}
