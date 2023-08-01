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
                    .opacity(card.email.isEmpty ? 0 : 1)
                }
                .padding(40)
                .padding(.bottom, 0)
                Spacer()
                    .frame(height: UIScreen.height * 0.1)
            }
            VStack {
                Spacer()
                HStack(alignment: .bottom, spacing: 30) {
                        Button(action: {
                            if let url = URL(string: "tel:\(card.contact)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Image("phoneActive")
                                .resizable()
                                .scaledToFit()
                                .shadow(color: Color(#colorLiteral(red: 0.051, green: 0.153, blue: 0.314, alpha: 1)).opacity(0.16), radius: 20, x: 28, y: 28)
                                .shadow(color: Color.white.opacity(1), radius: 48, x: -23, y: -23)
                        }
                    
                    Button(action: {
                        if let url = URL(string: "sms:\(card.contact)") {
                            UIApplication.shared.open(url)
                        }
                    }){
                        Image("MsgActive")
                            .resizable()
                            .scaledToFit()
                            .shadow(color: Color(#colorLiteral(red: 0.051, green: 0.153, blue: 0.314, alpha: 1)).opacity(0.16), radius: 20, x: 28, y: 28)
                            .shadow(color: Color.white.opacity(1), radius: 48, x: -23, y: -23)
                        
                    }
                    Button(action: {
                        if let url = URL(string: "mailto:\(card.email)") {
                            UIApplication.shared.open(url)
                        }
                    }){
                        if card.email.isEmpty {
                            Image("MailMy")
                                .resizable()
                                .scaledToFit()
                                .shadow(color: Color(#colorLiteral(red: 0.051, green: 0.153, blue: 0.314, alpha: 1)).opacity(0.16), radius: 20, x: 28, y: 28)
                                .shadow(color: Color.white.opacity(1), radius: 48, x: -23, y: -23)
                        } else {
                            Image("MailActive")
                                .resizable()
                                .scaledToFit()
                                .shadow(color: Color(#colorLiteral(red: 0.051, green: 0.153, blue: 0.314, alpha: 1)).opacity(0.16), radius: 20, x: 28, y: 28)
                                .shadow(color: Color.white.opacity(1), radius: 48, x: -23, y: -23)
                        }
                           
                    }
                    .disabled(card.email.isEmpty)
                    
                    VStack {
                        if expand {
                            if !socialMediaLinks.isEmpty {
                                VStack(spacing: 20) {
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
                                            }
                                        }
                                    }
                                }
                                .padding()
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
                                    .shadow(color: Color(#colorLiteral(red: 0.051, green: 0.153, blue: 0.314, alpha: 1)).opacity(0.16), radius: 20, x: 28, y: 28)
                                    .shadow(color: Color.white.opacity(1), radius: 48, x: -23, y: -23)
                                
                            } else {
                                Circle()
                                    .foregroundColor(.white)
                                    .shadow(color: Color(#colorLiteral(red: 0.051, green: 0.153, blue: 0.314, alpha: 1)).opacity(0.16), radius: 20, x: 28, y: 28)
                                    .shadow(color: Color.white.opacity(1), radius: 48, x: -23, y: -23)
                                    .overlay(
                                Image("AddUp")
                                    .resizable()
                                    .scaledToFit()
                                )
                            }
                        }
                    }
                    .animation(.spring())
                }
                .padding()
            }
        }
        .background(Image("\(card.designType)")
            .resizable().scaledToFit())
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: .constant(ProfileCardModel.sampleData[1]), isFromMy: true)
    }
}
