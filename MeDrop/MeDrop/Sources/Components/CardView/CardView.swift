//
//  CardView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//

import Foundation
import SwiftUI

struct CardView: View {
    var card: ProfileCardModel
    var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.height * 0.6 * (3/5), height: UIScreen.height * 0.6)
                .background(Image("\(card.designType)-background").resizable().scaledToFit())
                .shadow(radius: 10)
                .overlay(
                    VStack {
                        Spacer()
                        infoDrawer(card: card)
                    }
                        .foregroundColor(.black)
                        .padding()
                )
                .foregroundColor(.clear)
    }
}

struct PlusCardView: View {
var body: some View {
    RoundedRectangle(cornerRadius: 20)
        .shadow(radius: 10)
        .padding()
        .frame(width: UIScreen.height * 0.6 * (3/5), height: UIScreen.height * 0.6)
        .foregroundColor(.white)
        .overlay(
            Image("Plus")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.width / 3)
        )
}
}

struct FinalCardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .shadow(radius: 15)
            .frame(width: UIScreen.height * 0.6 * (3/5), height: UIScreen.height * 0.6)
            .padding()
            .overlay(
                Text("Final")
                    .foregroundColor(.white)
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: ProfileCardModel.sampleData[1])
    }
}

