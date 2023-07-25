//
//  NewCardView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct NewCardView: View {
    @State private var newCard = ProfileCardModel.emptyCard
    @State var isShowingColorSelectView: Bool = false
    @Binding var cards: [ProfileCardModel]
    @Binding var isFinish: Bool
    
    var body: some View {
        NavigationStack{
            CardInfoView(card: $newCard, isFinish: $isFinish, isShowingColorSelectView: $isShowingColorSelectView)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("다음") {
                            print(newCard)
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
                    ColorSelectView(card: $newCard, isFinish: $isFinish)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("완료") {
                                    cards.append(newCard)
                                    isFinish.toggle()
                                }
                            }
                        }
                }
        }
    }
}

struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView(cards:.constant( ProfileCardModel.sampleData), isFinish: .constant(false))
    }
}
