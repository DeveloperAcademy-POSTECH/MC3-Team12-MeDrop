//
//  ImageRender.swift
//  MeDrop
//
//  Created by SY AN on 2023/08/02.
//

import SwiftUI

struct ImageRender: View {
    var body: some View {
        ShareLink(item: Image(uiImage: generateSnapshot(card: ProfileCardModel.sampleData[1])), preview: SharePreview("Weather Chart", image: Image("\(ProfileCardModel.sampleData[1].designType)-circle")))
            {
                Image("ExportButton")
                    .resizable()
                    .frame(width: UIScreen.width * 0.15, height: UIScreen.width * 0.15)
                    .scaledToFit()
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
            }
    }
}

struct ImageRender_Previews: PreviewProvider {
    static var previews: some View {
        ImageRender()
    }
}
