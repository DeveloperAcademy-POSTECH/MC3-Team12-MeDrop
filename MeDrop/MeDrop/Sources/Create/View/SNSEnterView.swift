//
//  SNSEnterView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI

struct SNSEnterView: View {
    @Binding var card: ProfileCardModel
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Spacer()
                
                VStack {
                    HStack {
                        Image("Instagram")
                        TextField("", text: $card.insta)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    HStack {
                        Image("twitter")
                        TextField("", text: $card.twitter)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    HStack {
                        Image("linkedin")
                        TextField("", text: $card.linkedin)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    HStack {
                        Image("youtube")
                        TextField("", text: $card.youtube)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    HStack {
                        Image("github")
                        TextField("", text: $card.github)
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
            .navigationTitle("SNS 정보 입력 문구")
        }
    }
}

struct SNSEnterView_Previews: PreviewProvider {
    static var previews: some View {
        SNSEnterView(card: .constant(ProfileCardModel.emptyCard), isPresented: .constant(true))
    }
}
