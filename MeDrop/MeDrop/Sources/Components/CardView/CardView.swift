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
                .shadow(radius: 10)
                .padding()
                .overlay(
                    VStack {
                        Spacer()
                        Image("\(card.type)")
                            .renderingMode(.template)
                            .foregroundColor(Color(.sRGB, red: card.color[0], green: card.color[1], blue: card.color[2]))
                            .padding()
                            .border(.black)
                        Spacer()
                        Text("\(card.introduction)")
                        Text("\(card.name)") 
                        Text("\(card.company)")
                        Text("\(card.job)")
                        Text("\(card.contact)")
                        Spacer()
                    }
                        .padding()
                        .border(.pink)
                        .foregroundColor(.black)
                )
                .foregroundColor(.white)
        }
    }
}

struct PlusCardView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .shadow(radius: 10)
                .padding()
                .overlay(
                    Text("+")
                        .foregroundColor(.white)
                )
            Spacer()
        }
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
