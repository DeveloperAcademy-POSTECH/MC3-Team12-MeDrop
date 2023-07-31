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
    @State var expand = false
    private var socialMediaLinks: [ProfileCardModel.SocialMediaLink] {
        card.socialMediaLinks
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(spacing: 12) {
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
                Spacer()
                    .frame(height: UIScreen.height * 0.1)
            }
            VStack {
                Spacer()
                HStack( alignment: .bottom, spacing: 0) {
                        Button(action: {
                            if let url = URL(string: "tel:\(card.contact)") {
                                UIApplication.shared.open(url)
                            }
                        }){
                            Image("PhoneMy")
                                .resizable()
                                .scaledToFit()
                        }
                    
                    Button(action:{
                        if let url = URL(string: "sms:\(card.contact)") {
                            UIApplication.shared.open(url)
                        }
                    }){
                        Image("MsgMy")
                            .resizable()
                            .scaledToFit()
                    }
                    Button(action: {
                        if let url = URL(string: "mailto:\(card.email)") {
                            UIApplication.shared.open(url)
                        }
                    }){
                        Image("MailMy")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    VStack {
                        if expand {
                            if !socialMediaLinks.isEmpty {
                                VStack{
                                    ForEach(socialMediaLinks, id: \.self) { link in
                                        Button(action: {
                                            if let url = URL(string: card.link(for: link)) {
                                                UIApplication.shared.open(url)
                                            }
                                        }) {
                                            VStack {
                                                Image(link.icon)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                                Text(link.name)
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(50)
                            }
                        }
                        Button(action: {
                            expand.toggle()
                        }){
                            if expand {
                                Image("AddDown")
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Image("AddUp")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                    .animation(.spring())
                }
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: .constant(ProfileCardModel.sampleData[1]), isFromMy: true)
    }
}
