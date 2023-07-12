//
//  onBoardView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import SwiftUI

struct OnBoardView: View {
    @State var selection: OnBoardTab = onBoardtabs.first!
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        print("Exit")
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                }
                TabView(selection: $selection) {
                    ForEach(onBoardtabs) { tab in
                        GeometryReader { proxy in
                            let size = proxy.size
                            OnBoardContentView(tab: tab)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))// 인디케이터 제거
                // .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .background {
                    Color.red
                }
                Text("Hello")
                AppleSignInButton()
                    .cornerRadius(100)
                    .frame(width: 268, height: 50)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 69)
        }
    }
}

struct OnBoardContentView: View {
    var tab: OnBoardTab
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(tab.content.rawValue.convertMarkDown())
                    .font(.regular(28))
                // .lineSpacing(30)
                    .multilineTextAlignment(.leading) // 왼쪽 정렬
                    .kerning(-0.4) // 자간 조정
                Spacer()
            }
            
            Spacer()
            
            Image(tab.image)
                .resizable() // 사이즈 조정 가능
                .aspectRatio(contentMode: .fit) // 프레임 사이즈에 맞게 이미지 사이즈 조정
                .frame(width: 300, height: 300) // 이미지 뷰 frame 사이즈 조정
            Spacer()
        }
    }
}

