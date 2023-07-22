//
//  MyCardsView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/22.
//

import SwiftUI

struct MyCardsView: View {
    @Binding var myCards: [ProfileCardModel]
    var body: some View {
        Text("MyCardsView")
    }
}

struct MyCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsView(myCards: .constant(ProfileCardModel.sampleData))
    }
}
