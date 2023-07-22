//
//  CardView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//

import Foundation
import SwiftUI

struct CardView: View {
    @Binding var card: ProfileCardModel
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.clear)
            .background(card.colorSet.cardColor)
    }
}
