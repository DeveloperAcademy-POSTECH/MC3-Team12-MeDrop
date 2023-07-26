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
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text("\(card.introduction)").font(.title).bold()
                    Spacer()
                }
                
                RoundedRectangle(cornerRadius: 15)
//                    .frame(height: UIScreen.height * 0.4)
//                    .padding()
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                ForEach(ContactButton.allCases, id: \.self) { contactButton in
                                    actionButtonDrawer(contactButton: contactButton, profileCard: card)
                                        .disabled(isFromMy)
                                }
                            }
                            .padding(.vertical)
                            // 컴포넌트화 예정 HStack + 폰트 + Padding
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(card.name)").padding(.bottom)
                                    Text("\(card.company)").padding(.bottom)
                                    Text("\(card.job)").padding(.bottom)
                                    Text("\(card.contact)").padding(.bottom)
                                    Text("\(card.email)")
                                }
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                ForEach(ContactButton.allCases, id: \.self) { contactButton in
                                    actionButtonDrawer(contactButton: contactButton, profileCard: card)
                                        .disabled(isFromMy)
                                }
                            }
                            Spacer()
                        }
                            .padding()
                    )
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
