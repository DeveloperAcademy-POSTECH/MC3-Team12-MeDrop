//
//  Extension+MyView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/11.
//

import Foundation
import SwiftUI

extension MyView {
    
    // My Profile에 표시되는 카드의 View 입니다.
    func carouselItemView(info: MyProfileCardInfo) -> some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(info.organization)
                        .font(.regular(14 * cardRatio))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, organizationRatio * cardHeight)
                    
                    Text(generateFullName(lastName: info.lastName, firstName: info.firstName))
                        .font(.black(48 * cardRatio))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, fullNameInnerPaddingRatio * cardHeight)
                        .border(width: 2, edges: [.bottom], color: generateCardTextColor(cardColor: info.cardColor))
                        .padding(.top, organizationFullNameGapRatio * cardHeight)
                    
                    Text(info.job)
                        .font(.bold(32 * cardRatio))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.vertical, jobInnerPaddingRatio * cardHeight)
                        .border(width: 2, edges: [.top, .bottom], color: generateCardTextColor(cardColor: info.cardColor))
                        .padding(.top, fullNameJobGapRatio * cardHeight)
                    
                    Text(info.phoneNumber)
                        .font(.bold(14 * cardRatio))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, jobPhoneNumberGapRatio * cardHeight)
                    
                    Text(info.description)
                        .font(.bold(14 * cardRatio))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, phoneNumberDescriptionGapRatio * cardHeight)
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        Text("More")
                        Image(systemName: "arrow.right")
                    }
                    .font(.bold(14 * cardRatio))
                    .frame(maxWidth: .infinity, maxHeight: cardHeight * moreButtonRatio, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.leading, leftPaddingRatio * cardWidth)
                .padding(.trailing, rightPaddingRatio * cardWidth)
                
                Image("VerticalPattern")
                    .resizable()
                    .frame(maxWidth: cardWidth * verticalPatternRatio, maxHeight: .infinity)
            }
            
            Image("HorizontalPattern")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: cardHeight * horizontalPatternRatio)
                .offset(y: -cardHeight * moreButtonRatio)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(info.cardColor)
        .foregroundColor(generateCardTextColor(cardColor: info.cardColor))
        .cornerRadius(10)
        .padding(.top, .spacing50 * cardRatio)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
    }
    
    // My Profile에 카드가 없을 때 표시되는 View 입니다.
    func emptyCarouselView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            Button {
            } label: {
                Image(systemName: "plus.square")
            }
            .font(.regular(60 * cardRatio))
            .frame(width: cardWidth, height: cardHeight)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.gray)
        .foregroundColor(Color.black)
        .cornerRadius(10)
        .padding(.top, .spacing50 * cardRatio)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
    }
    
    // My Profile에 카드가 최대로 만들어졌을 때 표시되는 View 입니다.
    func fullCarouselView() -> some View {
        ZStack {
            Text("내 프로필 카드는\n최대 5개까지 만들 수 있습니다.\n\n새로운 프로필 카드를 만드시려면\n기존 카드를 삭제해 주시기 바랍니다.\n\n삭제하고 싶은 카드를 길게 누른 뒤\n삭제 버튼을 누르시면 삭제됩니다.")
            .font(.regular(18 * cardRatio))
            .frame(width: cardWidth, height: cardHeight)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.gray)
        .foregroundColor(Color.black)
        .cornerRadius(10)
        .padding(.top, .spacing50 * cardRatio)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
    }
    
    // carouselItemView에서 따로 따로 받은 성과 이름을 합쳐주기 위한 function 입니다.
    // 일단은 한글 이름을 가정하여 성+이름을 해 주어 full name을 만들었습니다.
    // 닉네임의 경우 firstName에 모두 저장하고 lastName을 빈 문자열로 설정하여 full name을 만들었습니다.
    func generateFullName(lastName: String, firstName: String) -> String {
        lastName.isEmpty ? firstName : firstName + " " + lastName
    }
    
    // carouselItemView에서 카드 배경 색상에 따른 카드 텍스트 색상을 결정하기 위한 function 입니다.
    // 카드 배경 색상이 검은색 또는 파란색인 경우 카드 텍스트 색상은 흰색으로,
    // 카드 배경 색상이 흰색 또는 빨간색 또는 라임색인 경우 카드 텍스트 색상은 검은색으로 설정하였습니다.
    func generateCardTextColor(cardColor: Color) -> Color {
        if cardColor == DesignSystemAsset.CardColor.black || cardColor == DesignSystemAsset.CardColor.blue1 {
            return DesignSystemAsset.CardText.white
        } else {
            return DesignSystemAsset.CardText.black
        }
    }
    
    // MyView에서 교환하기 button을 만들어주기 위한 function 입니다.
    func exchangeButton(buttonColor: Color) -> some View {
        Button {
        } label: {
            Label("교환하기", systemImage: "arrow.2.squarepath")
        }
        .font(.semiBold(20 * cardRatio))
        .frame(maxWidth: .infinity, maxHeight: .spacing32 * cardRatio, alignment: .trailing)
        .foregroundColor(buttonColor)
        .disabled(false)
    }
}
