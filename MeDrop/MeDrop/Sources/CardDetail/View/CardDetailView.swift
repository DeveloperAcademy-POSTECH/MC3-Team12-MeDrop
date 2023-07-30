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
            Spacer()
            VStack (spacing: 12) {
                HStack {
                    Text("\(card.name)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                VStack {
                    HStack {
                        Text("\(card.company)")
                        Spacer()
                    }
                    HStack {
                        Text("\(card.job)")
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                HStack {
                    Image(systemName: "phone.fill")
                    Text("\(card.contact)")
                    Spacer()
                }
                HStack {
                    Image(systemName: "envelope.fill")
                    Text("\(card.email)")
                    Spacer()
                }
            }
            .padding(40)
            
            HStack(spacing: 10) {
                Circle()
                Circle()
                Circle()
                Circle()
            }
            .padding()
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: .constant(ProfileCardModel.sampleData[1]), isFromMy: true)
    }
}
