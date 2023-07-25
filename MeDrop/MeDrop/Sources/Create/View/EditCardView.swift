//
//  EditCardView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/25.
//

import SwiftUI

struct EditCardView: View {
    @State var isShowingColorSelectView: Bool = false
    @Binding var card: ProfileCardModel
    @Binding var isFinish: Bool
    
    @State var editingCard = ProfileCardModel.emptyCard
    
    var body: some View {
        NavigationStack{
            CardInfoView(card: $card, isFinish: $isFinish, isShowingColorSelectView: $isShowingColorSelectView)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("다음") {
                            card = ProfileCardModel.sampleData[1]
                            isShowingColorSelectView.toggle()
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("취소") {
                            isFinish.toggle()
                        }
                    }
                }
                .navigationDestination(isPresented: $isShowingColorSelectView) {
                    ColorSelectView(card: $card, isFinish: $isFinish)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("완료") {
                                    isFinish.toggle()
                                }
                            }
                        }
                }
        }
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView(card: .constant(ProfileCardModel.sampleData[1]), isFinish: .constant(false))
    }
}
