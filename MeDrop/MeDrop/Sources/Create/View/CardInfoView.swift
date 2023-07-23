//
//  CardInfoView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/23.
//

import SwiftUI

struct CardInfoView: View {
    @Binding var card: ProfileCardModel
    @Binding var isFinish: Bool
    @State var isInputFinished: Bool = false
    
    var body: some View {
        VStack {
            Text("CardInfoView")
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("다음") {
                    isInputFinished.toggle()
                }
                .navigationDestination(isPresented: $isInputFinished) {
                    ColorSelectView(isFinish: $isFinish)
                }
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("취소") {
                    isFinish.toggle()
                }
            }
        }
    }
}

struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView(card: .constant(ProfileCardModel.emptyCard), isFinish: .constant(false))
    }
}
