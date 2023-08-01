//
//  CardViewModel.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/30.
//

import SwiftUI

@ViewBuilder
func infoDrawer (card: ProfileCardModel) -> some View {
    VStack {
        HStack {
            Text("\(card.name)")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.bottom)
        HStack {
            Text("\(card.company)")
                .font(.title2)
            Spacer()
        }
        HStack {
            Text("\(card.job)")
                .font(.title3)
            Spacer()
        }
        HStack {
            Text("\(card.contact)")
            Spacer()
        }
        .padding(.vertical)
    }
    
}
