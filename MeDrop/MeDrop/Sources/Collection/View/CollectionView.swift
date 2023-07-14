//
//  CollectionView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import SwiftUI

struct CollectionView: View {
    @State var sortedBy = "가나다 순"
    
    let screenWidth: Double
    let cardWidth: Double
    let cardHeight: Double
    let cardRatio: Double
    
    init() {
        self.screenWidth = UIScreen.main.bounds.size.width
        cardWidth = screenWidth - .spacing40
        cardHeight = cardWidth * widthHeightRatio
        cardRatio = cardWidth / 348
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
            }
            .frame(maxWidth: .infinity, maxHeight: .spacing32 * cardRatio, alignment: .trailing)
            
            Text("Collection")
                .font(.black(34 * cardRatio))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Menu {
                sortingButton(order: "가나다 순")
                sortingButton(order: "새로운 순")
                sortingButton(order: "오래된 순")
            } label: {
                Text(sortedBy)
                Image(systemName: "chevron.down")
            }
            .font(.semiBold(20 * cardRatio))
            .frame(maxWidth: .infinity, maxHeight: .spacing32 * cardRatio, alignment: .trailing)
            .foregroundColor(DesignSystemAsset.IconColor.blue1)
            
            Spacer()
        }
        .padding(.horizontal, .spacing20)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
