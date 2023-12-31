//
//  CardView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//

import Foundation
import SwiftUI

struct CardView: View {
    var card: ProfileCardModel
    var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.height * 0.6 * (3/5), height: UIScreen.height * 0.6)
                .background(Image("\(card.designType)-background").resizable().scaledToFit())
                .shadow(radius: 10)
                .overlay(
                    VStack {
                        Spacer()
                        infoDrawer(card: card)
                    }
                        .foregroundColor(.black)
                        .padding()
                )
                .foregroundColor(.clear)
    }
}

struct PlusCardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .shadow(radius: 10)
            .padding()
            .frame(width: UIScreen.height * 0.6 * (3/5), height: UIScreen.height * 0.6)
            .foregroundColor(.white)
            .overlay(
                Image("Plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.width / 5)
            )
    }
}

struct FinalCardView: View {
    var body: some View {
       
            RoundedRectangle(cornerRadius: 20)
                .shadow(radius: 10)
                .overlay(
                    ZStack {
                        Image("PlusDisabled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.width / 5)
                        VStack {
                            Spacer()
                            HStack(spacing: 0) {
                                Text("최대 ")
                                Text("5개")
                                    .fontWeight(.bold)
                                Text("까지 만들 수 있어요.")
                            }
//                            .font(.caption)
                            .padding(3)
                            .foregroundColor(.black)
                            
                            VStack{
                                Text("카드를 추가하려면")
                                Text("기존 명함을 위로 스와이프해서 지워주세요.")
                                Spacer()
                                    .frame(height: UIScreen.height * 0.05)
                            }
                                .foregroundColor(DesignSystemAsset.gray3)
                                .font(.caption)
                        }
                    }
                )
                .padding()
                .frame(width: UIScreen.height * 0.6 * (3/5), height: UIScreen.height * 0.6)
                .foregroundColor(.white)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
//        CardView(card: ProfileCardModel.sampleData[1])
        FinalCardView()
    }
}

