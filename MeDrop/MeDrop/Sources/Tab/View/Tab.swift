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
}

var tabItems = [
    TabItem(type: .tabType, icon: "person.text.rectangle.fill", text: "ME CARD", tab: .my),
    TabItem(type: .buttonType, icon: "arrow.2.squarepath", text: "Exchange", tab: nil),
    TabItem(type: .tabType, icon: "person.crop.rectangle.stack", text: "YOUR CARDS", tab: .your)
]
