//
//  onBoardView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import SwiftUI

struct OnBoardView: View {
    @ObservedObject var viewModel = OnBoardViewModel()
    
    @State var selection:Int = 1
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Text(" **Hello**\nWorld ")
                TabView(selection: $selection) {
                    OnBoardContentView(selection: 1, content: .obt1)
                        .tag(1)
                    OnBoardContentView(selection: 2, content: .obt2)
                        .tag(2)
                    OnBoardContentView(selection: 3, content: .obt3)
                        .tag(3)
                    OnBoardContentView(selection: 4, content: .obt4)
                        .tag(4)
                }.tabViewStyle(.page(indexDisplayMode: .never))// 인디케이터 제거
                // .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            
            }
        }
    }
}

struct OnBoardContentView: View {
    var selection: Int
    var content: DesignSystemAsset.OnBoardText
    
    var body: some View {
        VStack(spacing: 30) {
            Text(content.rawValue.convertMarkDown())
                .font(.regular(28))
               // .lineSpacing(30)
                .multilineTextAlignment(.leading) // 왼쪽 정렬
                .kerning(-0.4) // 자간 조정
            
            Image("onBoardImg\(selection)")
                .resizable() // 사이즈 조정 가능
                .aspectRatio(contentMode: .fit) // 프레임 사이즈에 맞게 이미지 사이즈 조정
                .frame(width: 300, height: 300) // 이미지 뷰 frame 사이즈 조정
        }
    }
}
