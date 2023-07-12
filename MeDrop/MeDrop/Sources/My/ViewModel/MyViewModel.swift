//
//  MyViewModel.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import Foundation
import SwiftUI

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
