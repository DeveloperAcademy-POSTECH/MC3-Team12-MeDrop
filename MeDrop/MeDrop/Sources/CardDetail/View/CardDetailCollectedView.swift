//
//  CardDetailCollectedView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct CardDetailCollectedView: View {
    @Binding var card: ProfileCardModel
    @Binding var cards: [ProfileCardModel]
    @State var isDelete = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        CardDetailView(card: $card, cards: $cards, isFromMy: false)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("삭제") {
                        isDelete.toggle()
                    }
                }
            }
            .confirmationDialog("카드를 삭제 하시겠습니까?\n카드 속 모든 정보가 ME DROP에서 제거됩니다.", isPresented: $isDelete, titleVisibility: .visible
            ) {
                Button("카드 삭제", role: .destructive) {
                    cards.removeAll { $0.id == card.id
                }
                    isDelete.toggle()
                    dismiss()
                }
                Button("취소", role: .cancel) {
                    isDelete.toggle()
                }
            }
    }
}

struct CardDetailCollectedView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailCollectedView(card: .constant(ProfileCardModel.sampleData[1]), cards: .constant(ProfileCardModel.sampleData))
    }
}
