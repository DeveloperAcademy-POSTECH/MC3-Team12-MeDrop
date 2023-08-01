//
//  SNSEnterView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI

struct SNSEnterView: View {
    @Binding var editingCard: ProfileCardModel
    @Binding var isPresented: Bool
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Spacer()
                
                VStack {
                    HStack {
                        Image("instagram_")
                        TextField("Instagram 아이디를 입력해주세요.", text: $editingCard.insta)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    HStack {
                        Image("twitter_")
                        TextField("Twitter 아이디를 입력해주세요.", text: $editingCard.twitter)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    HStack {
                        Image("linkedin_")
                        TextField("LinkedIn 프로필 링크를 입력해주세요.", text: $editingCard.linkedin)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    HStack {
                        Image("youtube_")
                        TextField("YouTube 채널 링크를 입력해주세요.", text: $editingCard.youtube)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    HStack {
                        Image("github_")
                        TextField("GitHub 링크를 입력해주세요.", text: $editingCard.github)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                Spacer()
                Spacer()    
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Text("확인").foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("링크를 추가해주세요.")
        }
    }
}

struct SNSEnterView_Previews: PreviewProvider {
    static var previews: some View {
        SNSEnterView(editingCard: .constant(ProfileCardModel.emptyCard), isPresented: .constant(true))
    }
}
