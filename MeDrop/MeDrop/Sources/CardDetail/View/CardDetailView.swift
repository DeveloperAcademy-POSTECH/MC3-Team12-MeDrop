//
//  CardDetailView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/23.
//

import SwiftUI

struct CardDetailView: View {
    @Binding var card: ProfileCardModel
    var isFromMy: Bool
    
    var body: some View {
        VStack {
            Text("CardDetailView")
            
            ForEach(ContactButton.allCases, id: \.self) { contactButton in
                actionButtonDrawer(contactButton: contactButton, profileCard: card)
                    .background((Color(.sRGB, red: card.color[0], green: card.color[1], blue: card.color[2])))
                    .disabled(isFromMy)
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: .constant(ProfileCardModel.sampleData[1]), isFromMy: true)
    }
}
