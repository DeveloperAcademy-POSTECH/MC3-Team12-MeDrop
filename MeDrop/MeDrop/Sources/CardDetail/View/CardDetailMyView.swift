//
//  CardDetailMyView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct CardDetailMyView: View {
    @Binding var card: ProfileCardModel
    @State var isShowingEdit: Bool = false
    @State var editingCard = ProfileCardModel.emptyCard
    
    var body: some View {
        CardDetailView(card: $card, isFromMy: true)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("편집") {
                        editingCard = card
                        isShowingEdit.toggle()
                    }
                }
            }
            .sheet(isPresented: $isShowingEdit) {
                EditCardView(originCard: $card, editingCard: $editingCard, isFinish: $isShowingEdit)
            }
    }
}

struct CardDetailMyView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailMyView(card: .constant(ProfileCardModel.sampleData[1]))
    }
}
