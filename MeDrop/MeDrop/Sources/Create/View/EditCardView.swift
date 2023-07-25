//
//  EditCardView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/25.
//

import SwiftUI

struct EditCardView: View {
    @State var isShowingColorSelectView: Bool = false
    @Binding var originCard: ProfileCardModel
    @Binding var editingCard: ProfileCardModel
    @Binding var isFinish: Bool
    
    var body: some View {
        NavigationStack{
            CardInfoView(card: $editingCard, isFinish: $isFinish, isShowingColorSelectView: $isShowingColorSelectView)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("다음") {
                            editingCard = ProfileCardModel.sampleData[3]
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
                    ColorSelectView(card: $editingCard, isFinish: $isFinish)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("완료") {
                                    originCard = editingCard
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
        EditCardView(originCard: .constant(ProfileCardModel.sampleData[1]),editingCard: .constant(ProfileCardModel.sampleData[3]), isFinish: .constant(false))
    }
}
