//
//  Tab.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/30.
//

import SwiftUI

enum TabItemType {
    case tabType
    case buttonType
}

struct TabItem: Identifiable {
    var id = UUID()
    var type: TabItemType
    var icon: String
    var text: String
    var tab: Tab?
}

enum Tab: String {
    case my
    case your
    case exchange
}

var tabItems = [
    TabItem(type: .tabType, icon: "person.text.rectangle", text: "내 명함", tab: .my),
    TabItem(type: .buttonType, icon: "arrow.2.squarepath", text: "", tab: .exchange),
    TabItem(type: .tabType, icon: "shared.with.you", text: "명함 지갑", tab: .your)
]
