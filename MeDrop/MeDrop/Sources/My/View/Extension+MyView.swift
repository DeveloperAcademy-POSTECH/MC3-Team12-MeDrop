//
//  Extension+MyView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/11.
//

import Foundation
import SwiftUI

extension MyView {
    func carouselItemView(info: MyProfileCardInfo) -> some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: 0) {
                VStack {
                    Text(info.organization)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, .spacing60)
                    
                    Text(generateFullName(lastName: info.lastName, firstName: info.firstName))
                        .font(.black(48))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                        .border(width: 2, edges: [.bottom], color: generateCardTextColor(cardColor: info.cardColor))
                        .padding(.bottom, 4)
                    
                    Text(info.job)
                        .font(.bold(32))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.vertical, 6)
                        .border(width: 2, edges: [.top, .bottom], color: generateCardTextColor(cardColor: info.cardColor))
                        .padding(.bottom, 2)
                    
                    Text(info.phoneNumber)
                        .font(.bold(14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 2)
                    
                    Text(info.description)
                        .font(.bold(14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        Text("More")
                        Image(systemName: "arrow.right")
                    }
                    .font(.bold(14))
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding([.horizontal, .top], .spacing12)
                
                Image("VerticalPattern")
                    .resizable()
                    .frame(maxWidth: cardWidth * verticalPatternRatio, maxHeight: .infinity)
            }
            
            Image("HorizontalPattern")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: cardHeight * horizontalPatternRatio)
                .offset(y: -40)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(info.cardColor)
        .foregroundColor(generateCardTextColor(cardColor: info.cardColor))
        .cornerRadius(10)
        .padding(.top, .spacing50)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
    }
    
    func emptyCarouselView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            Button {
            } label: {
                Image(systemName: "plus.square")
            }
            .font(.regular(60))
            .frame(width: cardWidth, height: cardHeight)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.gray)
        .foregroundColor(Color.black)
        .cornerRadius(10)
        .padding(.top, .spacing50)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
    }
    
    func fullCarouselView() -> some View {
        ZStack {
            Text("내 프로필 카드는\n최대 5개까지 만들 수 있습니다.\n\n새로운 프로필 카드를 만드시려면\n기존 카드를 삭제해 주시기 바랍니다.\n\n삭제하고 싶은 카드를 길게 누른 뒤\n삭제 버튼을 누르시면 삭제됩니다.")
            .font(.regular(18))
            .frame(width: cardWidth, height: cardHeight)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.gray)
        .foregroundColor(Color.black)
        .cornerRadius(10)
        .padding(.top, .spacing50)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
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
