//
//  MyViewModel.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import Foundation
import SwiftUI

// 더미 데이터를 만들기 위해 생성한 Profile Card에 들어갈 정보들의 구조입니다.
// Model의 Profile+ProfileCardModel과 합치면 될 것 같습니다.
// 이때 바뀌거나 추가된 변수명이 있을 시 MyView에도 마찬가지로 바꿔주어야 합니다.
struct MyProfileCardInfo: Identifiable {
    let id = UUID()
    var idx: Int
    var firstName: String
    var lastName: String
    var organization: String
    var job: String
    var phoneNumber: String
    var description: String
    var cardColor: Color
}

// MyView를 테스트하기 위한 더미 데이터 입니다.
// 현재는 5개로 고정이 되어 있지만, 나중에는 initialization 시 DB에서 가지고 있는 정보만큼 만들어주면 될 듯 합니다.
// 이 데이터들을 배열의 형태로 MyView에 넘겨주어 사용합니다.
// 각각 0개 - 5개일 때 MyView에 기획한 대로 카드가 표시되는 것을 확인했습니다.
class MyViewModel: ObservableObject {
    @Published var myProfileCards: [MyProfileCardInfo]

    init() {
        self.myProfileCards = [
            MyProfileCardInfo(
                idx: 1,
                firstName: "이재석",
                lastName: "",
                organization: "서울대학교",
                job: "학부생",
                phoneNumber: "010-6381-6412",
                description: "안녕하세요, 이재석 입니다.",
                cardColor: DesignSystemAsset.CardColor.black
            ),
            MyProfileCardInfo(
                idx: 2,
                firstName: "Jay",
                lastName: "",
                organization: "애플 디벨로퍼 아카데미",
                job: "주니어 러너",
                phoneNumber: "010-6381-6412",
                description: "안녕하세요, Jay 입니다.",
                cardColor: DesignSystemAsset.CardColor.blue1
            ),
            MyProfileCardInfo(
                idx: 3,
                firstName: "남승오",
                lastName: "",
                organization: "P&G",
                job: "매니저",
                phoneNumber: "010-0000-0000",
                description: "안녕하세요, 남승오 입니다.",
                cardColor: DesignSystemAsset.CardColor.neonPink
            ),
            MyProfileCardInfo(
                idx: 4,
                firstName: "Seng",
                lastName: "",
                organization: "애플 디벨로퍼 아카데미",
                job: "주니어 러너",
                phoneNumber: "010-0000-0000",
                description: "안녕하세요, Seng 입니다.",
                cardColor: DesignSystemAsset.CardColor.lime
            ),
            MyProfileCardInfo(
                idx: 5,
                firstName: "김동윤",
                lastName: "",
                organization: "POSTECH MSO Lab.",
                job: "대학원생",
                phoneNumber: "010-1111-1111",
                description: "안녕하세요, 김동윤 입니다.",
                cardColor: DesignSystemAsset.CardColor.black
            )
        ]
    }
}
