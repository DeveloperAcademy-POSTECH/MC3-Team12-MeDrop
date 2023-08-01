//
//  CustomCarouselView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/08/01.
//

import SwiftUI

struct CustomCarouselView: View {
    
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    @Binding var cards: [ProfileCardModel]
    @Binding var activeIndex: Int
    @State private var move = false
    
    @State var isDetail = false
    
    @State private var isShowingDeleteIcon = false
    @State private var dragOffset: CGSize = .zero // 드래그 오프셋을 추적하기 위한 변수 추가
    @State private var stoppedOffset: CGFloat = 0
    @State var isDelete = false
    let cardMaxHeight: CGFloat = UIScreen.height * 0.08
    let deleteIconMaxOpacity: Double = 1.0
    let deleteIconMinOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            //            ForEach(store.items) { item in
            ForEach($cards.indices, id: \.self) { index in
                // article view
                DeletableCard(card: $cards[index])
                    .onTapGesture {
                        isDetail.toggle()
                    }
                    .navigationDestination(isPresented: $isDetail) {
                        CardDetailMyView(card: $cards[Int(snappedItem)], cards: $cards)
                    }
                    .scaleEffect(0.9 - abs(distance(index)) * 0.2)
                    .opacity(Double(index) == draggingItem ? 1.0 : 0.5)
                    .offset(x: myXOffset(index), y: max(dragOffset.height + stoppedOffset, -cardMaxHeight))
                    .zIndex(1.0 - abs(distance(index)) * 0.1)
                    .rotation3DEffect(.degrees(Double(move ? 6 : -6)), axis: (x: CGFloat(move ? 90 : -45), y: CGFloat(move ? -30 : -60), z: 0.0))
                    .animation(.easeInOut.speed(0.1).repeatForever(), value: move)
                    .onAppear {
                        move.toggle()
                    }
            }
        }
        .simultaneousGesture(
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
                    withAnimation(.easeIn) {
                        
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
        return (angle) * 290
    }
}
struct CustomCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCarouselView(cards: .constant(ProfileCardModel.sampleData), activeIndex: .constant(0))
    }
}
