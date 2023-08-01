//
//  CustomCarouselView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/08/01.
//

import SwiftUI

struct CarouselDesignView: View {
    
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    @Binding var card: ProfileCardModel
    @State var cards:[ProfileCardModel] = []
    @Binding var activeIndex: Int
    @State private var move = false
    @Binding var color: String
    
    var body: some View {
        
        ZStack {
//            ForEach(store.items) { item in
            ForEach($cards.indices, id: \.self) { index in
                
                // article view
                CardDesignView(card: $cards[index], color: $color, design: String(index))
                    .frame(width: UIScreen.width * 0.69, height: UIScreen.height * 0.53).padding()
                
                .scaleEffect(0.9 - abs(distance(index)) * 0.2 )
                .opacity(Double(index) == draggingItem ? 1.0 : 0.5)
                .offset(x: myXOffset(index), y: 0)
                .zIndex(1.0 - abs(distance(index)) * 0.1)
            }
        }.onAppear {
            for _ in 0..<5 {
                cards.append(card)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width < 0 {
                        draggingItem = draggingItem - snappedItem > 1.0 ? snappedItem + 1.0 : snappedItem - value.translation.width / 150
                    } else {
                        draggingItem = snappedItem - draggingItem > 1.0 ? snappedItem - 1.0 : snappedItem - value.translation.width / 150
                    }
                    
                    print("dragging", draggingItem)
                    print("snapped", snappedItem)
                }
                .onEnded { value in
                    withAnimation(.easeIn)
                    {
                        
                        draggingItem = round(draggingItem)
                        
                        print("dragging", draggingItem)
                        print("snapped", snappedItem)
                        
                        //Get the active Item index
                        
                        
                        if Int(self.draggingItem) >= cards.count  {
                            draggingItem = Double(cards.count - 1)
                        } else if self.draggingItem < 0 {
                            self.activeIndex = 0
                            draggingItem = Double(0.0)
                        }
                        
                        snappedItem = draggingItem
                        self.activeIndex = Int(draggingItem)
                        print("activeIndex", activeIndex)
                    }
                }
        )
    }
    
    func distance(_ item: Int) -> Double {
        return -(draggingItem - Double(item))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle =  distance(item)
//        print(item, angle)
        return (angle) * 250
    }
}
struct CarouselDesignView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselDesignView(card: .constant(ProfileCardModel.sampleData[0]), activeIndex: .constant(0), color: .constant("0"))
    }
}
