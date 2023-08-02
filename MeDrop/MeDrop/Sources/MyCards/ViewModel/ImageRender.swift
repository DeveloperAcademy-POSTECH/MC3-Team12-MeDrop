//
//  ImageRender.swift
//  MeDrop
//
//  Created by SY AN on 2023/08/02.
//

import SwiftUI

struct ImageRenderView: View {
    var card: ProfileCardModel
    var body: some View {
        ShareLink(item: Image(uiImage: generateSnapshot(card: card)), preview: SharePreview("ME DROP", image: Image("\(card.designType)-circle")))
            {
                Image("ExportButton")
                    .resizable()
                    .frame(width: UIScreen.width * 0.15, height: UIScreen.width * 0.15)
                    .scaledToFit()
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
            }
    }
}

struct ImageRenderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRenderView(card: ProfileCardModel.sampleData[1])
    }
}
