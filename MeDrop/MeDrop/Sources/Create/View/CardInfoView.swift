//
//  CardInfoView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/23.
//

import SwiftUI

struct CardInfoView: View {
    // 보여줄 정보 담긴 카드
    @Binding var card: ProfileCardModel
    @Binding var isFinish: Bool
    @Binding var isShowingColorSelectView: Bool
    
    var body: some View {
        VStack {
            Text("CardInfoView")
        }
    }
}

struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView (card: .constant(ProfileCardModel.emptyCard), isFinish: .constant(false), isShowingColorSelectView: .constant(false))
    }
}
