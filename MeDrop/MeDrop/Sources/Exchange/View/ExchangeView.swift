//
//  ExchangeView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/22.
//

import SwiftUI

struct ExchangeView: View {
    @Binding var collectedCards: [ProfileCardModel]
    var newYourCard = ProfileCardModel.sampleData[1]
    var body: some View {
        VStack{
            Text("Exchange View")
            Button(action:{
                collectedCards.append(newYourCard)
            }){
                Text("교환")
            }
        }
    }
}

struct ExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeView(collectedCards: .constant(ProfileCardModel.sampleData))
    }
}
