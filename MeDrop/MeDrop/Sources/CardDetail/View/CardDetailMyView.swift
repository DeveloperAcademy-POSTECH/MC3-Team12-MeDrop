//
//  CardDetailMyView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct CardDetailMyView: View {
    @Binding var card: ProfileCardModel
    @Binding var cards: [ProfileCardModel]
    @State var isShowingEdit: Bool = false
    @State var editingCard = ProfileCardModel.emptyCard
    @State var navigationControl: Int = 0
    
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
            .navigationDestination(isPresented: $isShowingEdit) {
                CreateCardView( editingCard: $editingCard,
                    originCard: $card, cards: $cards, isCreate: false)
            }
        
//            .sheet(isPresented: $isShowingEdit) {
//                EditCardView(originCard: $card, editingCard: $editingCard, isFinish: $isShowingEdit)
//            }
    }
}

struct CardDetailMyView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailMyView(card: .constant(ProfileCardModel.sampleData[1]), cards: .constant(ProfileCardModel.sampleData))
    }
}
