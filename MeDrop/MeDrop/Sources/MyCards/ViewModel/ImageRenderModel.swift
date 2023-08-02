//
//  ImageRenderModel.swift
//  MeDrop
//
//  Created by SY AN on 2023/08/02.
//

import SwiftUI

@MainActor
func generateSnapshot(card: ProfileCardModel) -> UIImage {
    let renderer = ImageRenderer(content: CardView(card: card))
 
    return renderer.uiImage ?? UIImage()
}
