//
//  CollectionView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import Foundation
import SwiftUI

struct CollectionView: View {
    @StateObject var collectionViewModel = CollectionViewModel()
    
    @State var sortedBy = "가나다 순"
    
    let screenWidth: Double
    let cardWidth: Double
    let cardHeight: Double
    let widthHeightRatio: Double = 8.56 / 5.39
    
    init() {
        self.screenWidth = UIScreen.main.bounds.size.width
        cardWidth = screenWidth - .spacing40 - .spacing20
        cardHeight = cardWidth * widthHeightRatio
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Collection")
                    .font(.black(34))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Menu {
                    Button {
                        self.sortedBy = "가나다 순"
                    } label: {
                        Text("가나다 순")
                        Spacer()
                        if sortedBy == "가나다 순" {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    Button {
                        self.sortedBy = "새로운 순"
                    } label: {
                        Text("새로운 순")
                        Spacer()
                        if sortedBy == "새로운 순" {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    Button {
                        self.sortedBy = "오래된 순"
                    } label: {
                        Text("오래된 순")
                        Spacer()
                        if sortedBy == "오래된 순" {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                } label: {
                    Text(sortedBy)
                    Image(systemName: "chevron.down")
                }
                .font(.regular(18))
                .frame(alignment: .trailing)
            }
            .border(Color.green)
            
//            ScrollView(showsIndicators: false) {
//                ZStack {
//                    ForEach(0..<colors.count) {
//                        Rectangle()
//                            .fill(colors[$0])
//                            .frame(width: cardWidth, height: cardHeight)
//                            .offset(y: CGFloat($0) * .spacing60)
//                    }
//                }
//                .border(Color.orange)
//            }
//            .frame(maxWidth: .infinity)
//            .border(Color.blue)
            
            Spacer()
        }
        .padding(.top, .spacing40)
        .padding(.horizontal, .spacing20)
        .border(Color.red)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
