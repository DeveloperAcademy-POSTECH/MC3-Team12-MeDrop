//
//  ProfileCardViewRatio.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/14.
//

import Foundation

// 기기의 크기에 따라 View가 다르게 보이는 문제를 해결하기 위해
// Figma에 그려진 Profile Card 내에서의 각 요소들의 비율을 이용하여 View를 그렸습니다.
// 아래는 해당 비율들을 전역 변수로 설정한 값 입니다.
public let widthHeightRatio: Double = 521 / 348
public let verticalPatternRatio: Double = 22 / 348
public let horizontalPatternRatio: Double = 172 / 521
public let moreButtonRatio: Double = 52 / 521
public let organizationRatio: Double = 6 / 521
public let organizationFullNameGapRatio: Double = 69 / 521
public let fullNameRatio: Double = 69 / 521
public let fullNameInnerPaddingRatio: Double = 9 / 521
public let fullNameJobGapRatio: Double = 19 / 521
public let jobRatio: Double = 177 / 521
public let jobInnerPaddingRatio: Double = 8 / 521
public let jobPhoneNumberGapRatio: Double = 5 / 521
public let phoneNumberRatio: Double = 233 / 521
public let phoneNumberDescriptionGapRatio: Double = 7 / 521
public let descriptionRatio: Double = 257 / 521
public let leftPaddingRatio: Double = 21 / (348 - 22)
public let rightPaddingRatio: Double = 7 / (348 - 22)
