//
//  ProfileView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//  Edited by Kimyejoon on 2023/07/09.
//

import Foundation
import SwiftUI

struct ProfileDetailView: View {
    @Binding var profileCard: ProfileCardModel
    var isFromMy: Bool
    
    var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: .infinity, height: UIScreen.main.bounds.height * 0.9)
                    .foregroundColor(.clear)
                    .background(profileCard.colorSet.contentBackgroundColor)
                    .cornerRadius(135, corners: [.bottomLeft])
                
                VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                    // 소속
                    Text(profileCard.company)
                        .font(Font.regular(11))
                    // 한 줄 소개
                    Text(profileCard.introduction)
                        .font(Font.bold(20))
                    
                        // 이름
                        Text(profileCard.name)
                            .font(Font.black(48))
                            .padding(.vertical, UIScreen.height * 0.04)
                    }
                    .foregroundColor(profileCard.colorSet.cardTextColor)
                    
                    HStack(spacing: 15) {
                        ForEach(ContactButton.allCases, id: \.self) { contactButton in
                            actionButtonDrawer(contactButton: contactButton, profileCard: profileCard)
                        }
                    }
                    //.padding(.top, UIScreen.height * 0.05)
                    Group {
                        VStack(alignment: .leading, spacing: 34) {
                            infoRowDrawer(label: "Phone Number", content: profileCard.contact)
                            infoRowDrawer(label: "Mail", content: profileCard.email)
                            infoRowDrawer(label: "Link", content: profileCard.link)
                        }
                        .padding(.top,  UIScreen.height * 0.04)
                        
                        Spacer()
                            .frame(height:  UIScreen.height * 0.05)
                        
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
                .border(.pink)
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            loadUserData()
        }
        .navigationTitle("상세페이지")
        .background(profileCard.colorSet.backgroundColor)
        .ignoresSafeArea()
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(profileCard: .constant(ProfileCardModel.sampleData[3]), isFromMy: true)
    }
}
