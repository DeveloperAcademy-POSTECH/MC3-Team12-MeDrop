//
//  CardDesignView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/08/01.
//

import SwiftUI

struct CardDesignView: View {
    @Binding var card: ProfileCardModel
    @Binding var color: String
    var design: String = "0"
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
                .background(Image("\(design)-\(color)-background").resizable().scaledToFit())
                .shadow(radius: 10)
        }
    }
}


struct CardDesignView_Previews: PreviewProvider {
    static var previews: some View {
        CardDesignView(card: .constant(ProfileCardModel.emptyCard), color: .constant("0"))
    }
}
