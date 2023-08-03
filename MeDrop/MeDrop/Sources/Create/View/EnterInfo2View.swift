//
//  EnterInfo2View.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI

struct EnterInfo2View: View {
    @Binding var navigationControl: Int
    
    @Binding var editingCard: ProfileCardModel
    @Binding var originCard: ProfileCardModel
    @State var isSNSLink = false
    
    @State var isBack = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    VStack(alignment: .leading) {
                        Text("한 줄 소개").font(
                            Font.custom("SF Pro Text", size: 17)
                            .weight(.bold)
                            )
                        VStack {
                                TextField("예) 성장하는 개발자 김드랍입니다.", text: $editingCard.introduction
                                ).font(Font.custom("SF Pro Text", size: 17))
                                
                            Rectangle()
                                .frame(height: 1)
                                
                        }.foregroundColor(DesignSystemAsset.gray1)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("이메일").font(
                            Font.custom("SF Pro Text", size: 17)
                            .weight(.bold)
                            )
                        VStack {
                                TextField("medrop@dp.com", text: $editingCard.email
                                ).font(Font.custom("SF Pro Text", size: 17))
                                
                            Rectangle()
                                .frame(height: 1)
                                
                        }.foregroundColor(DesignSystemAsset.gray1)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("링크")
                            .font(
                            Font.custom("SF Pro Text", size: 17)
                            .weight(.bold)
                            )
                        VStack {
                            HStack {
                                if editingCard.insta.isEmpty && editingCard.linkedin.isEmpty && editingCard.youtube.isEmpty && editingCard.github.isEmpty && editingCard.twitter.isEmpty{
                                    Text("더 많은 링크를 추가하세요").font(Font.custom("SF Pro Text", size: 17))
                                        .foregroundColor(DesignSystemAsset.gray1)
                                }
                                else {
                                    if editingCard.insta.isEmpty == false {
                                        Image("instagram_").resizable().frame(width: 24, height: 24) }
                                    if editingCard.twitter.isEmpty == false {
                                        Image("twitter_").resizable().frame(width: 24, height: 24)
                                    }
                                    if editingCard.linkedin.isEmpty == false {
                                        Image("linkedin_")
                                    .resizable().frame(width: 24, height: 24)
                                    }
                                    if editingCard.youtube.isEmpty == false {
                                        Image("youtube_").resizable().frame(width: 24, height: 24)
                                    }
                                    if editingCard.github.isEmpty == false {
                                        Image("github_").resizable().frame(width: 24, height: 24)
                                    }
                                }
                                Spacer()
                                Button(action: { isSNSLink.toggle()}) {
                                    Image(systemName: "plus.circle").foregroundColor(.black)
                                }
                            }
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }
                        VStack {
                            HStack {
                                    Image("link_").resizable().frame(width:24, height: 24)
                                TextField("블로그, 홈페이지 등의 주소를 입력해주세요.", text: $editingCard.link).foregroundColor(.gray)
                                Spacer()
                            }
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }.padding(.top)
                        
                    }.padding()
                    Spacer()
                    HStack {
                        
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.2)){
                                navigationControl -= 1 }}
                        ) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 0.96, green: 0.95, blue: 0.91))
                                Text("이전")
                                    .font(Font.custom("SF Pro Text", size: 17))
                                    .foregroundColor(DesignSystemAsset.gray3)
                            }
                        }
                        Button(action: { withAnimation(.easeIn(duration: 0.2)){
                            navigationControl += 1 }}) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color(red: 0.33, green: 0.38, blue: 0.54))
                                    Text("다음")
                                        .font(Font.custom("SF Pro Text", size: 17))
                                        .foregroundColor(DesignSystemAsset.white1)
                                }
                        }
                    }
                    .frame(height: UIScreen.height * 0.07)
                    .padding()
                }.navigationTitle("추가 정보를 입력해주세요.")
                .sheet(isPresented: $isSNSLink) {
                    SNSEnterView(editingCard: $editingCard, isPresented: $isSNSLink)
                }
                .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                isBack.toggle()
                            }) {
                                Image("x").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.width*0.04, height: UIScreen.height * 0.04)
                                .foregroundColor(.black)
                                .padding()
                            }
                        }
            }
            }
            .alert("돌아가시겠어요?", isPresented: $isBack) {
                Button("확인", role: .destructive) {
                    dismiss()
                }
                Button("취소", role: .cancel) {
                    isBack.toggle()
                }
            } message: {
                Text("지금 돌아간다면 정보는 저장되지 않습니다. ")
            }
        }
    }
}

struct EnterInfo2View_Previews: PreviewProvider {
    static var previews: some View {
        EnterInfo2View(navigationControl: .constant(0), editingCard: .constant(ProfileCardModel.emptyCard), originCard: .constant(ProfileCardModel.sampleData[0]))
    }
}
