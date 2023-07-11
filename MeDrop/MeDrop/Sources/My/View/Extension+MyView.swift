//
//  Extension+MyView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/11.
//

import Foundation
import SwiftUI

extension MyView {
    func carouselContainerView() -> some View {
        TabView {
            if myViewModel.myProfileCards.isEmpty {
                emptyCarouselView()
            }
            ForEach(myViewModel.myProfileCards) { myProfileCard in
                carouselItemView(info: myProfileCard)
            }
            if myViewModel.myProfileCards.count == 5 {
                fullCarouselView()
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    func carouselItemView(info: MyProfileCardInfo) -> some View {
        VStack {
            Text(generateFullName(lastName: info.lastName, firstName: info.firstName))
            Text(info.organization)
            Text(info.job)
            Text(info.phoneNumber)
            Text(info.description)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(info.cardColor)
        .foregroundColor(generateCardTextColor(cardColor: info.cardColor))
        .padding(.bottom, .spacing40)
    }
    
    func emptyCarouselView() -> some View {
        VStack {
            Button {
            } label: {
                Image(systemName: "plus.square")
            }
            .font(.regular(40))
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.gray)
        .foregroundColor(Color.black)
        .padding(.bottom, .spacing40)
    }
    
    func fullCarouselView() -> some View {
        VStack {
            Text("최대로 만들 수 있는 갯수를 초과 하셨습니다.\n새롭게 제작하길 원하신다면 기존의 카드를 삭제 바랍니다.\n삭제 방법:\n삭제하고 싶은 카드 꾹 눌러서 삭제")
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.gray)
        .foregroundColor(Color.black)
        .padding(.bottom, .spacing40)
    }
    
    func generateFullName(lastName: String, firstName: String) -> String {
        lastName.isEmpty ? firstName : firstName + " " + lastName
    }
    
    func generateCardTextColor(cardColor: Color) -> Color {
        if cardColor == DesignSystemAsset.CardColor.black || cardColor == DesignSystemAsset.CardColor.blue1 {
            return DesignSystemAsset.CardText.white
        } else {
            return DesignSystemAsset.CardText.black
        }
    }
}
