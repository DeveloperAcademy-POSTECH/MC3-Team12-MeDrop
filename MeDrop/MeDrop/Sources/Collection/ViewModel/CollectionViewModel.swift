//
//  CollectionViewModel.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/11.
//

import Foundation
import SwiftUI

struct CollectionProfileCardInfo: Identifiable {
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

class CollectionViewModel: ObservableObject {
    @Published var collectionProfileCards: [CollectionProfileCardInfo]
    @Published var sortedStates: [String]
    
    // 현재는 더미 데이터, 나중에 DB와 연동할 때 DB에 저장된 남의 프로필 카드 개수만큼 생성해주는 것으로 수정
    init() {
        self.sortedStates = ["가나다 순", "새로운 순", "오래된 순"]
        self.collectionProfileCards = [
            CollectionProfileCardInfo(
                idx: 0,
                firstName: "JAESEOK",
                lastName: "LEE",
                organization: "Seoul National University",
                job: "Undergraduate Student",
                phoneNumber: "010-6381-6412",
                description: "Hi, my name is JAESEOK LEE.",
                cardColor: DesignSystemAsset.CardColor.black
            ),
            CollectionProfileCardInfo(
                idx: 1,
                firstName: "Jay",
                lastName: "",
                organization: "Apple Developer Academy",
                job: "Tech",
                phoneNumber: "010-6381-6412",
                description: "Hi, my name is Jay.",
                cardColor: DesignSystemAsset.CardColor.blue1
            ),
            CollectionProfileCardInfo(
                idx: 2,
                firstName: "Seung Oh",
                lastName: "Nam",
                organization: "P&G",
                job: "Operations Manager",
                phoneNumber: "010-0000-0000",
                description: "Hi, my name is Seung Oh Nam.",
                cardColor: DesignSystemAsset.CardColor.neonPink
            ),
            CollectionProfileCardInfo(
                idx: 3,
                firstName: "Seng",
                lastName: "",
                organization: "Apple Developer Academy",
                job: "Domain",
                phoneNumber: "010-0000-0000",
                description: "Hi, my name is Seng.",
                cardColor: DesignSystemAsset.CardColor.lime
            ),
            CollectionProfileCardInfo(
                idx: 4,
                firstName: "동윤",
                lastName: "김",
                organization: "POSTECH MSO Lab.",
                job: "Graduate Student",
                phoneNumber: "010-1111-1111",
                description: "안녕하세요, 김동윤 입니다.",
                cardColor: DesignSystemAsset.CardColor.black
            )
        ]
    }
}
