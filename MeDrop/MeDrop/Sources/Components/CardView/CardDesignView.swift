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
        
        RoundedRectangle(cornerRadius: 20)
            .frame(width: UIScreen.height * 0.5 * (3/5), height: UIScreen.height * 0.5)
            .background(Image("\(design)-\(color)-background").resizable().scaledToFit())
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
            .padding()
    }
}


struct CardDesignView_Previews: PreviewProvider {
    static var previews: some View {
        CardDesignView(card: .constant(ProfileCardModel.sampleData[0]), color: .constant("0"))
    }
}

