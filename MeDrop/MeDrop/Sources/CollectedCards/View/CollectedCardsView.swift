//
//  CollectedCardsView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct CollectedCardsView: View {
    @State var isDetail: Bool = false
    @Binding var yourCards: [ProfileCardModel]
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach($yourCards.indices, id: \.self) { index in
                    Button(action: {isDetail.toggle()}) {
                        CardView(card: $yourCards[index])
                    }
                    .tag(index)
                    .navigationDestination(isPresented: $isDetail) {
                        CardDetailCollectedView(card: $yourCards[index])
                    }
                }
            }
            .navigationTitle("Collections")
        }
    }
}

struct CollectedCardsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectedCardsView(yourCards: .constant(ProfileCardModel.sampleData))
    }
}
