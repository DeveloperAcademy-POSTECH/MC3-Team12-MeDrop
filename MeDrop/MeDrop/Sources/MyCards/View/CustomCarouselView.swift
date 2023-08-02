//
//  CustomCarouselView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/08/01.
//

import SwiftUI

struct CustomCarouselView: View {
    // 좌우 스와이프 관련 변수
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @Binding var activeIndex: Int
    @State private var move = false
    
    // 카드 배열 변수
    @Binding var cards: [ProfileCardModel]
    
    // 다른 페이지 이동 변수
    @State var isDetail = false
    @State var isCreate = false

    // 카드 생성 변수
    @State var makingCard: ProfileCardModel = ProfileCardModel()
    
    var body: some View {
        ZStack {
            ForEach($cards.indices, id: \.self) { index in
                DeletableCardView(card: $cards[index], cards: $cards)
                    .onTapGesture {
                        isDetail.toggle()
                        print(index)
                    }
                    .navigationDestination(isPresented: $isDetail) {
                            CardDetailMyView(card: $cards[Int(index)], cards: $cards)
                    }
                    .scaleEffect(0.9 - abs(distance(index)) * 0.2)
                    .opacity(Double(index) == draggingItem ? 1.0 : 0.5)
                    .offset(x: myXOffset(index))
                    .zIndex(1.0 - abs(distance(index)) * 0.1)
                    .rotation3DEffect(.degrees(Double(move ? 6 : -6)), axis: (x: CGFloat(move ? 90 : -45), y: CGFloat(move ? -30 : -60), z: 0.0))
                    .animation(.easeInOut.speed(0.1).repeatForever(), value: move)
            }
            
            if cards.count != 5 {
                Button(action: { isCreate.toggle()}) {
                    PlusCardView()
                }
                .scaleEffect(cards.isEmpty ? 1 : (1.0 - abs(distance(cards.count)) * 0.2))
                .opacity(cards.isEmpty ? 1 : (Double(cards.count) == draggingItem ? 1.0 : 0.5))
                .offset(x: cards.isEmpty ? 0 : myXOffset(cards.count))
                .zIndex(1.0 - abs(distance(cards.count)) * 0.1)
            } else {
                FinalCardView()
                    .scaleEffect(1 - abs(distance(cards.count)) * 0.2)
                    .opacity(Double(cards.count) == draggingItem ? 1.0 : 0.5)
                    .offset(x: myXOffset(cards.count))
                    .zIndex(1.0 - abs(distance(cards.count)) * 0.1)
            }
        }
        .onAppear {
            makingCard = ProfileCardModel.emptyCard
            move.toggle()
        }
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width < 0 {
                        draggingItem = draggingItem - snappedItem > 1.0 ? snappedItem + 1.0 : snappedItem - value.translation.width / 150
                    } else {
                        draggingItem = snappedItem - draggingItem > 1.0 ? snappedItem - 1.0 : snappedItem - value.translation.width / 150
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeIn) {
                        draggingItem = round(draggingItem)
                        
                        if Int(self.draggingItem) >= cards.count + 1 {
                            draggingItem = Double(cards.count)
                        } else if self.draggingItem < 0 {
                            self.activeIndex = 0
                            draggingItem = Double(0.0)
                        }
                        
                        snappedItem = draggingItem
                        self.activeIndex = Int(draggingItem)
                    }
                }
        )
        .navigationDestination(isPresented: $isCreate) {
            CreateCardView(editingCard: $makingCard, originCard: $makingCard, cards: $cards, isCreate: true)
        }
    }
    
    func distance(_ item: Int) -> Double {
        return -(draggingItem - Double(item))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle =  distance(item)
        return (angle) * 290
    }
}
struct CustomCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCarouselView(activeIndex: .constant(0), cards: .constant(ProfileCardModel.sampleData))
    }
}
