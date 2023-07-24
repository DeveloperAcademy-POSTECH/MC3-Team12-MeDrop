//
//  ImageRenderView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct ImageRenderView: View {
    var card: ProfileCardModel
    var body: some View {
        ShareLink(
            item: Image(uiImage: generateSnapshot(card: card)),
            message: Text("MEdrop"),
            preview: SharePreview("MeDrop",image: Image(uiImage: generateSnapshot(card: card)))){
                Image(systemName: "paperplane.fill")
            }
    }
}


struct ImageRenderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRenderView(card: ProfileCardModel.sampleData[1])
    }
}
