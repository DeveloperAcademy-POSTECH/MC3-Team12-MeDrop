//
//  MyView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import Foundation
import SwiftUI

struct MyView: View {
    @StateObject var myViewModel = MyViewModel()
    
    @State var selectedMyProfileCardIndex = 1
    
    let screenWidth: Double
    let cardWidth: Double
    let cardHeight: Double
    let widthHeightRatio: Double = 521 / 348
    
    let verticalPatternRatio: Double = 22 / 348
    let horizontalPatternRatio: Double = 172 / 521
    
    init() {
        self.screenWidth = UIScreen.main.bounds.size.width
        cardWidth = screenWidth - .spacing40
        cardHeight = cardWidth * widthHeightRatio
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
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
                    Image(systemName: "gear.badge.questionmark")
                }
                .font(.semiBold(24))
                .frame(maxWidth: .infinity, maxHeight: .spacing32, alignment: .trailing)
                .foregroundColor(Color.black)
                
                Text("My Profile")
                    .font(.black(34))
                    .frame(maxWidth: .infinity, alignment: .leading)
                //                .border(Color.green)
                
                if selectedMyProfileCardIndex == myViewModel.myProfileCards.count + 1 {
                    VStack {
                    }.frame(maxWidth: .infinity, maxHeight: .spacing32, alignment: .trailing)
                } else {
                    Button {
                    } label: {
                        Label("교환하기", systemImage: "arrow.2.squarepath")
                    }
                    .font(.semiBold(20))
                    .frame(maxWidth: .infinity, maxHeight: .spacing32, alignment: .trailing)
                    .foregroundColor(DesignSystemAsset.IconColor.blue1)
                }
                
                Spacer()
            }
            .padding(.horizontal, .spacing20)
            
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
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
