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
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .padding()
                .overlay(
                    VStack {
                        Spacer()
                        Text("\(card.introduction)")
                        Text("\(card.name)")
                        Text("\(card.company)")
                        Text("\(card.job)")
                        Text("\(card.contact)")
                        Spacer()
                    }
                        .padding()
                        .foregroundColor(.black)
                )
                .foregroundColor(.clear)
                .background(Image("\(card.designType)-background").resizable().scaledToFit())
                .shadow(radius: 10)
        }
    }
}

struct PlusCardView: View {
    var body: some View {
        Image("PlusCard")
            .resizable()
            .scaledToFit()
            .padding()
            .shadow(radius: 10)
    }
}

struct FinalCardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .shadow(radius: 15)
            .padding()
            .overlay(
                Text("Final")
                    .foregroundColor(.white)
            )
    }
}
