//
//  ProfileView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//  Edited by Kimyejoon on 2023/07/09.
//

import Foundation
import SwiftUI

@ViewBuilder
func actionButtonDrawer(sfsymbol: String, labelText: String, buttonColor: Color, buttonTextColor: Color, phoneNumber: String) -> some View {
    Button(action: {
        if let url = URL(string: "sms:\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }) {
        Group {
            VStack(spacing: 2) {
                Image(systemName: "\(sfsymbol)")
                    .tint(.black)
                    .font(.system(size: 20))
                Text("\(labelText)")
                    .font(.semiBold(11))
            }
            .foregroundColor(buttonTextColor)
        }
        .frame(width: 76, height: 66)
        .background(buttonColor)
        .cornerRadius(14)
    }
}

@ViewBuilder
func infoRowDrawer(label: String, content: String) -> some View {
    VStack(alignment: .leading) {
        Text("\(label)")
          .font(Font.regular(14))
        Text("\(content)")
          .font(Font.bold(17))
    }
}

struct ProfileDetailView: View {
    @Binding var profileCard: ProfileCardModel
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: .infinity, height: UIScreen.height * 0.8)
                    .foregroundColor(.clear)
                    .background(profileCard.colorSet.contentBackgroundColor)
                    .cornerRadius(135, corners: [.bottomLeft])
                
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                    // 소속
                    Text(profileCard.company)
                        .font(Font.regular(11))
                        .padding(.top, 57)
                    // 한 줄 소개
                    Text(profileCard.introduction)
                        .font(Font.bold(20))
                        .padding(.top, 15)
                    
                        // 이름
                        Text(profileCard.name)
                            .font(Font.black(48))
                            .padding(.top, 48)
                    }
                    .foregroundColor(profileCard.colorSet.cardTextColor)
                    
                    HStack(spacing: 15) {
                        //actionButtonDrawer(sfsymbol: "phone.fill", labelText: "Phone", buttonColor: profileCard.colorSet.buttonColor, buttonTextColor: profileCard.colorSet.buttonTextColor)
                        actionButtonDrawer(sfsymbol: "message", labelText: "Message", buttonColor: profileCard.colorSet.buttonColor, buttonTextColor: profileCard.colorSet.buttonTextColor, phoneNumber: profileCard.contact)
                        //actionButtonDrawer(sfsymbol: "envelope.fill", labelText: "mail", buttonColor: profileCard.colorSet.buttonColor, buttonTextColor: profileCard.colorSet.buttonTextColor)
                        //actionButtonDrawer(sfsymbol: "safari.fill", labelText: "Safari", buttonColor: profileCard.colorSet.buttonColor, buttonTextColor: profileCard.colorSet.buttonTextColor)
                    }
                    .padding(.top, 43)
                    
                    Group {
                        VStack(alignment: .leading, spacing: 34) {
                            infoRowDrawer(label: "Phone Number", content: profileCard.contact)
                            infoRowDrawer(label: "Mail", content: profileCard.email)
                            infoRowDrawer(label: "Link", content: profileCard.link)
                        }
                        .padding(.top, 32)
                        
                        Spacer()
                            .frame(height: 46)
                        
                        HStack {
                            Spacer()
                            Text(profileCard.job)
                                .font(
                                    Font.custom("SF Pro Text", size: 32)
                                        .weight(.bold)
                                )
                        }
                    }
                    .foregroundColor(profileCard.colorSet.cardTextColor)
                }
                .padding(.horizontal, 15)
            }
            Spacer()
        }
        .background(profileCard.colorSet.backgroundColor)
        .ignoresSafeArea()
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(profileCard: .constant(ProfileCardModel.sampleData[2]))
    }
}
