//
//  onBoardView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import SwiftUI

struct OnBoardView: View {
    @State var currentTab: OnBoardTab = onBoardTabs.first!
    @State var offset: CGFloat = .zero
    let hPadding: CGFloat = 16
    
    var body: some View {
        GeometryReader { outerProxy in
            let screenSize = outerProxy.size
            
            ZStack(alignment: .top) {
                Color.white.ignoresSafeArea()
                VStack(spacing: 30) {
                    //dynamicCustomHeader(screenSize)
                    TabView(selection: $currentTab) {
                        ForEach(onBoardTabs) { tab in
                            GeometryReader { _ in
                                OnBoardContentView(tab: tab)
                            }
                            .offsetX { value in
                                if currentTab == tab {
                                    /*
                                     To Keep Track of Total Offset
                                     Here is a Trick, Simply Multiply Offset with Width of the Tab View * Current Index
                                     
                                     */
                                    
                                    offset = value - (screenSize.width * CGFloat(tab.index))
                                }
                            }
                            .tag(tab)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                   // .tabViewStyle(.page(indexDisplayMode: .never))// 인디케이터 제거
                    AppleSignInButton()
                        .cornerRadius(100)
                        .frame(width: 268, height: 50)
                }
                .padding(.horizontal, hPadding)
                .padding(.bottom, 69)
                .padding(.top, 50)
            }
            .frame(width: screenSize.width, height: screenSize.height)
        }
        .onAppear{
            setupAppearance()
        }
    }
//    @ViewBuilder
//    func dynamicCustomHeader(_ size: CGSize) -> some View {
//        HStack(spacing: 5) {
//            ForEach(onBoardTabs) { tab in
//                ZStack { // 움직이는 막대기
//                    if currentTab == tab {
//                        Rectangle().fill(DesignSystemAsset.mainBlue)
//                    } else {
//                        Rectangle().fill(DesignSystemAsset.gray2)
//                    }
//                }
//
//                .frame(height: 4)
//            }
//        }
//    }
//

    
    struct OnBoardContentView: View {
        var tab: OnBoardTab
        
        var body: some View {
            VStack(spacing: 50) {
                HStack(spacing:0) {
                    Text(tab.content.rawValue.convertMarkDown())
                        .font(.regular(28))
                        .multilineTextAlignment(.leading) // 왼쪽 정렬
                        .kerning(-0.4) // 자간 조정
                    Spacer()
                }
                
             //   Spacer()
                
                Image(tab.image)
                    .resizable() // 사이즈 조정 가능
                    .aspectRatio(contentMode: .fit) // 프레임 사이즈에 맞게 이미지 사이즈 조정
                    .frame(width: 300, height: 300) // 이미지 뷰 frame 사이즈 조정
            }
        }
    }
}

extension OnBoardView {
    func setupAppearance() {
      UIPageControl.appearance().currentPageIndicatorTintColor = .black
      UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}
