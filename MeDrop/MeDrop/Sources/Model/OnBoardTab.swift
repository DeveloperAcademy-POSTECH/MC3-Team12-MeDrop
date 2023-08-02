//
//  OnBoardTab.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/12.
//

import Foundation

struct OnBoardTab: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var index: Int
    var image: String
    var content: DesignSystemAsset.OnBoardText
}

var onBoardTabs: [OnBoardTab] = [
    .init(index: 0, image: DesignSystemAsset.OnBoardImage.onboard1, content: .obt1),
    .init(index: 1, image: DesignSystemAsset.OnBoardImage.onboard2, content: .obt2),
    .init(index: 2, image: DesignSystemAsset.OnBoardImage.onboard3, content: .obt3),
]
