//
//  CardDetailView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/23.
//

import SwiftUI

struct CardDetailView: View {
    @Binding var card: ProfileCardModel
    @State var isUp: Bool = true
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
            .padding(.bottom, 0)
            
            HStack(spacing: 0) {
                Image("PhoneMy")
                    .resizable()
                    .scaledToFit()
                Image("MsgMy")
                    .resizable()
                    .scaledToFit()
                Button(action:{}){
                    Image("MailMy")
                        .resizable()
                        .scaledToFit()
                }
                ZStack {
                    Circle()
                        .foregroundColor(.clear)
                    Button(action: { isUp.toggle()}){
                        if isUp {
                            Image("AddUp")
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image("AddDown")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
            .padding()
            .padding(.top, 0)
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: .constant(ProfileCardModel.sampleData[1]), isFromMy: true)
    }
}
