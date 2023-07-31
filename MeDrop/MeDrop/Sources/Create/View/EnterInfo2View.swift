//
//  EnterInfo2View.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI

struct EnterInfo2View: View {
    @Binding var navigationControl: Int
    
    @Binding var card: ProfileCardModel
    @State var isSNSLink = false
    
    @State var isBack = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("이메일")
                    VStack {
                            TextField("fakeID@xxx.xxx", text: $card.email
                            )
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("관련링크").padding(.bottom)
                    VStack {
                        HStack {
                            Text("SNS 링크를 추가하세요").foregroundColor(.gray)
                            Spacer()
                            Button(action: { isSNSLink.toggle()}) {
                                Image(systemName: "plus.circle").foregroundColor(.black)
                            }
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }.sheet(isPresented: $isSNSLink) {
                        SNSEnterView(card: $card, isPresented: $isSNSLink)
                    }
                    VStack {
                        HStack {
                            TextField("그 외 사이트를 추가하세요", text: $card.link).foregroundColor(.gray)
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
                            RoundedRectangle(cornerRadius: 10).foregroundColor(DesignSystemAsset.gray4)
                            Text("이전").foregroundColor(DesignSystemAsset.gray2)
                        }
                    }
                    Button(action: { withAnimation(.easeIn(duration: 0.2)){
                        navigationControl += 1 }}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Text("다음").foregroundColor(.white)
                        }
                    }
                }
                .frame(height: UIScreen.height * 0.08)
                .padding()
            }.navigationTitle("추가 정보 입력 문구")
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
                }.alert("돌아가시겠어요?", isPresented: $isBack) {
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
        EnterInfo2View(navigationControl: .constant(0), card: .constant(ProfileCardModel.sampleData[0]))
    }
}
