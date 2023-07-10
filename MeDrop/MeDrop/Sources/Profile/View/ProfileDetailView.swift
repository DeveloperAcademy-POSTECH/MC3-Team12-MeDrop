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

struct ProfileDetailView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: .infinity, height: 755)
                    .background(.black)
                    .cornerRadius(135, corners: [.bottomLeft])
                
                VStack(alignment: .leading, spacing: 0) {
                    // 소속
                    Text("􀣺 Apple Developer Academy")
                        .font(Font.regular(11))
                        .foregroundColor(.white)
                        .padding(.top, 120)
                    // 한 줄 소개
                    Text("한 줄 소개; 안녕하세요 어쩌구 저쩌구")
                        .font(Font.bold(20))
                        .foregroundColor(.white)
                        .padding(.top, 21)
                    
                    Group {
                        // 이름
                        Text("이우빈")
                            .font(Font.black(48))
                            .foregroundColor(.white)
                            .padding(.top, 39)
                    }
                    
                    HStack(spacing: 15) {
                        actionButtonDrawer(sfsymbol: "phone.fill", labelText: "Phone")
                        actionButtonDrawer(sfsymbol: "message", labelText: "Message")
                        actionButtonDrawer(sfsymbol: "envelope.fill", labelText: "mail")
                        actionButtonDrawer(sfsymbol: "safari.fill", labelText: "Safari")
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 35) {
                        VStack(alignment: .leading) {
                            Text("LinkedIn 􀉣")
                              .font(
                                Font.custom("SF Pro Text", size: 17)
                                  .weight(.bold)
                              )
                              .foregroundColor(.white)
                            Text("www.LinkedInLinkedIn//LinkedIn.com")
                              .font(Font.custom("SF Pro Text", size: 14))
                              .underline()
                              .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Instagram")
                              .font(
                                Font.custom("SF Pro Text", size: 17)
                                  .weight(.bold)
                              )
                              .foregroundColor(.white)
                            Text("@dskd__ksdjcnk____")
                              .font(Font.custom("SF Pro Text", size: 14))
                              .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Portfolio")
                              .font(
                                Font.custom("SF Pro Text", size: 17)
                                  .weight(.bold)
                              )
                              .foregroundColor(.white)
                            Text("Project; TBD (Me-Drop)")
                              .font(Font.custom("SF Pro Text", size: 14))
                              .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 32)
                    
                    Spacer()
                        .frame(height: 45)
                    
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
            
            Button {
                print("Link")
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Text("Link")
                      .font(
                        Font.custom("SF Pro Text", size: 17)
                          .weight(.semibold)
                      )
                      .multilineTextAlignment(.center)
                      .foregroundColor(.black)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .frame(minWidth: 314, maxWidth: 314, maxHeight: .infinity, alignment: .center)
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            }
            .padding(.top, 13)
        }
        .ignoresSafeArea()
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView()
    }
}
