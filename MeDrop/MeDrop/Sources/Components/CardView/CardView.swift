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
                        Text("\(card.introduction)")
                        Text("\(card.name)") 
                        Text("\(card.company)")
                        Text("\(card.job)")
                        Text("\(card.contact)")
                    }
                        .padding()
                        .border(.pink)
                        .foregroundColor(.black)
                )
                .border(.gray)
                .foregroundColor(.white)
//            Spacer()
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
