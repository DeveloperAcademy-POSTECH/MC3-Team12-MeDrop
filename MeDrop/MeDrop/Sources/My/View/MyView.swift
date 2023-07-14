//
//  MyView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import Foundation
import SwiftUI

struct MyView: View {
    // MyViewModel에서 데이터를 불러옵니다.
    @StateObject var myViewModel = MyViewModel()
    
    // TabView에서 선택된 카드가 무엇인지에 따라 다른 View를 그리기 위한 변수입니다.
    @State var selectedMyProfileCardIndex = 1
    
    let screenWidth: Double
    let cardWidth: Double
    let cardHeight: Double
    let cardRatio: Double
    
    init() {
        self.screenWidth = UIScreen.main.bounds.size.width
        cardWidth = screenWidth - .spacing40
        cardHeight = cardWidth * widthHeightRatio
        cardRatio = cardWidth / 348
    }
    
    var body: some View {
        ZStack {
            // 카드를 띄워주고 옆으로 넘기기 위한 TabView 입니다.
            // 현재 선택된 카드(현재 화면에 띄워진 카드)의 index를 selectedMyProfileCardIndex에 저장합니다.
            // ForEach문을 통해 각 프로필 데이터마다 카드를 그려주고, selection을 위해 tag를 달아줍니다.
            // if-else문을 통해 카드의 개수에 따라 카드 추가 화면과 삭제 안내 문구 화면을 띄워줍니다.
            TabView(selection: $selectedMyProfileCardIndex) {
                ForEach(myViewModel.myProfileCards) { myProfileCard in
                    carouselItemView(info: myProfileCard)
                        .tag(myProfileCard.idx)
                }
                if myViewModel.myProfileCards.count != 5 {
                    emptyCarouselView()
                        .tag(myViewModel.myProfileCards.count + 1)
                } else {
                    fullCarouselView()
                        .tag(myViewModel.myProfileCards.count + 1)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            //
            VStack(spacing: 0) {
                // 앱 소개, 로그아웃, 계정 삭제를 위한 메뉴 영역입니다.
                Menu {
                    Button {
                    } label: {
                        Label("Me-Drop", systemImage: "questionmark.app")
                    }
                    Button {
                    } label: {
                        Label("로그아웃", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                    Button(role: .destructive) {
                    } label: {
                        Label("회원 탈퇴", systemImage: "exclamationmark.triangle")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
                .font(.semiBold(24 * cardRatio))
                .frame(maxWidth: .infinity, maxHeight: .spacing32 * cardRatio, alignment: .trailing)
                .foregroundColor(Color.black)
                
                // 타이틀 영역입니다.
                Text("My Profile")
                    .font(.black(34 * cardRatio))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // 카드에 따라 교환하기 버튼을 활성화 / 비활성화 시켜줍니다.
                // 이때 비활성화 되었을 경우 버튼의 색상을 회색으로 바꿔줍니다.
                if selectedMyProfileCardIndex == myViewModel.myProfileCards.count + 1 {
                    exchangeButton(buttonColor: DesignSystemAsset.IconColor.gray4)
                        .disabled(true)
                } else {
                    exchangeButton(buttonColor: DesignSystemAsset.IconColor.blue1)
                        .disabled(false)
                }
                
                Spacer()
            }
            .padding(.horizontal, .spacing20)
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
