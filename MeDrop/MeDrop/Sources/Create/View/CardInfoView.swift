//
//  CardInfoView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/23.
//

import SwiftUI

struct CardInfoView: View {
    @Binding var card: ProfileCardModel
    var body: some View {
        VStack{
            Text("CardInfoView")
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("이전") {
                    
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("다음") {
                    
                }
            }
        }
    }
}

struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView(card: .constant(ProfileCardModel.emptyCard))
    }
}
