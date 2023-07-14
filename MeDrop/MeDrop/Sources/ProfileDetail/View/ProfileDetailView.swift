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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Rectangle()
                .frame( maxHeight: UIScreen.height * 0.9)
                .foregroundColor(.clear)
                .background(profileCard.colorSet.contentBackgroundColor)
                .cornerRadius(135, corners: [.bottomLeft])
                .overlay {
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: UIScreen.height * 0.12)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(profileCard.company)
                                .font(Font.regular(11))
                                .padding(.vertical)
                            Text(profileCard.introduction)
                                .font(Font.bold(20))
                            Spacer()
                            Text(profileCard.name)
                                .font(Font.black(48))
                            Spacer()
                        }
                        .frame(height: UIScreen.height * 0.25)
                        HStack(spacing: 15) {
                            ForEach(ContactButton.allCases, id: \.self) { contactButton in
                                actionButtonDrawer(contactButton: contactButton, profileCard: profileCard)
                            }
                        }
                        .padding(.bottom)
                        Spacer()
                        VStack(alignment: .leading, spacing: 34) {
                            infoRowDrawer(label: "Phone Number", content: profileCard.contact)
                            infoRowDrawer(label: "Mail", content: profileCard.email)
                            infoRowDrawer(label: "Link", content: profileCard.link)
                        }
                        .padding(.vertical)
                        Spacer()
                        HStack {
                            Spacer()
                            Text(profileCard.job)
                                .font(
                                    Font.custom("SF Pro Text", size: 32)
                                        .weight(.bold)
                                )
                        }
                        .padding(.vertical)
                    }
                    .padding()
                    .foregroundColor(profileCard.colorSet.cardTextColor)
                }
            ZStack {
                Spacer()
                Button(action: {
                    // 삭제하기 버튼 동작
                }) {
                    Text("삭제하기")
                    Image(systemName: "trash")
                }
                .font(Font.regular(14))
                .foregroundColor(DesignSystemAsset.ButtonColor.button4)// 변경
                .frame(width: UIScreen.width * 0.6, height: UIScreen.height * 0.01)
                .padding()
                .background(DesignSystemAsset.ButtonColor.button4) // 변경
                .cornerRadius(10)
                .padding()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Group {
                        Image(systemName: "chevron.left")
                        Text("뒤로가기")
                    }
                    .foregroundColor(profileCard.colorSet.cardTextColor)
                }
                .onTapGesture {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("상세페이지")
                    .foregroundColor(profileCard.colorSet.cardTextColor)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                }) {
                    Group{
                        Text("편집")
                        Image(systemName: "square.and.pencil")
                    }
                    .foregroundColor(profileCard.colorSet.cardTextColor)
                }
                .opacity(isFromMy ? 1 : 0)
            }
        }
        .background(profileCard.colorSet.backgroundColor)
    }
}

 struct ProfileDetailView_Previews: PreviewProvider {
     static var previews: some View {
         ProfileDetailView(profileCard: .constant(ProfileCardModel.sampleData[1]), isFromMy: true)
     }
 }
