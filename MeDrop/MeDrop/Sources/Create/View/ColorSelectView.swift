//
//  ColorSelectView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct ColorSelectView: View {
    @Binding var card: ProfileCardModel
    @Binding var isFinish: Bool
    var body: some View {
            VStack {
                Text("ColorSelectView")
            }
    }
}

struct ColorSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectView(card: .constant(ProfileCardModel.emptyCard), isFinish: .constant(false))
    }
}
