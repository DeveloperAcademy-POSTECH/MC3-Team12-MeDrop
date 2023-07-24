//
//  ImageRenderViewModel.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI


@MainActor
func generateSnapshot(card: ProfileCardModel) -> UIImage {
    let renderer = ImageRenderer(content: ProfileDetailView(profileCard: .constant(card), isFromMy: true)
        .frame(width: UIScreen.width, height: UIScreen.height))
    renderer.scale = UIScreen.main.scale
    return renderer.uiImage ?? UIImage()
}
