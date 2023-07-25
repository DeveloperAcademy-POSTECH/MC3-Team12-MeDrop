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
    var body: some View {
        CardDetailView(card: $card, isFromMy: true)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("편집") {
                        isShowingEdit.toggle()
                    }
                }
            }
            .sheet(isPresented: $isShowingEdit) {
                EditCardView(card: $card, isFinish: $isShowingEdit)
            }
    }
}

struct CardDetailMyView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailMyView(card: .constant(ProfileCardModel.sampleData[1]))
    }
}
