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
func actionButtonDrawer(sfsymbol: String, labelText: String) -> some View {
    Button {
        //동작
    } label: {
        VStack(spacing: 2) {
            Image(systemName: "\(sfsymbol)")
                .tint(.black)
                .font(.system(size: 20))
            Text("\(labelText)")
                .font(.semiBold(11))
                .foregroundColor(.black)
        }
        .frame(width: 76, height: 66)
        .background(DesignSystemAsset.ButtonColor.gray3)
        .cornerRadius(14)
    }
}

@ViewBuilder
func infoRowDrawer(label: String, content: String) -> some View {
    VStack(alignment: .leading) {
        Text("\(label)")
          .font(Font.regular(14))
          .foregroundColor(.white)
        Text("\(content)")
          .font(Font.bold(17))
          .foregroundColor(.white)
    }
}

struct ProfileDetailView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: .infinity, height: 664)
                    .background(.black)
                    .cornerRadius(135, corners: [.bottomLeft])
                
                VStack(alignment: .leading, spacing: 0) {
                    // 소속
                    Text("􀣺 Apple Developer Academy")
                        .font(Font.regular(11))
                        .foregroundColor(.white)
                        .padding(.top, 57)
                    // 한 줄 소개
                    Text("한 줄 소개; 안녕하세요 어쩌구 저쩌구")
                        .font(Font.bold(20))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    Group {
                        // 이름
                        Text("이우빈")
                            .font(Font.black(48))
                            .foregroundColor(.white)
                            .padding(.top, 48)
                    }
                    
                    HStack(spacing: 15) {
                        actionButtonDrawer(sfsymbol: "phone.fill", labelText: "Phone")
                        actionButtonDrawer(sfsymbol: "message", labelText: "Message")
                        actionButtonDrawer(sfsymbol: "envelope.fill", labelText: "mail")
                        actionButtonDrawer(sfsymbol: "safari.fill", labelText: "Safari")
                    }
                    .padding(.top, 43)
                    
                    VStack(alignment: .leading, spacing: 34) {
                        infoRowDrawer(label: "Phone Number", content: "010-0000-0000")
                        infoRowDrawer(label: "Mail", content: "kdbvkdbsvbn@gmail.com")
                        infoRowDrawer(label: "Link", content: "dbksbkdj//cadcjk.akcdk.com")
                    }
                    .padding(.top, 32)
                    
                    Spacer()
                        .frame(height: 46)
                    
                    HStack {
                        Spacer()
                        Text("Designer.")
                          .font(
                            Font.custom("SF Pro Text", size: 32)
                              .weight(.bold)
                          )
                          .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 15)
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView()
    }
}
