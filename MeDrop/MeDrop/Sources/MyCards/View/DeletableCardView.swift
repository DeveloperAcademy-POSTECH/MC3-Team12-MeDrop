//
//  DeletableCardView.swift
//  MeDrop
//
//  Created by SY AN on 2023/08/01.
//

import SwiftUI

struct DeletableCardView: View {
    @Binding var card: ProfileCardModel
    @State private var isShowingDeleteIcon = false
    @State private var dragOffset: CGSize = .zero // 드래그 오프셋을 추적하기 위한 변수 추가
    @State private var stoppedOffset: CGFloat = 0
    let cardMaxHeight: CGFloat = UIScreen.height * 0.08
    let deleteIconMaxOpacity: Double = 1.0
    let deleteIconMinOpacity: Double = 0.0
    
    @State var isDelete = false
    @Binding var cards: [ProfileCardModel]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button(action: {isDelete.toggle()}) {
                    DeleteView()
                }
                .foregroundColor(.black)
                .opacity(isShowingDeleteIcon ? deleteIconMaxOpacity : deleteIconMinOpacity)
                .animation(.spring())
                
                .padding()
            }
            
            CardView(card: card)
                .offset(y: max(dragOffset.height + stoppedOffset, -cardMaxHeight)) // 멈출 높이에 오프셋 추가
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isShowingDeleteIcon = value.translation.height < 0
                            dragOffset = value.translation
                        }
                        .onEnded { _ in
                            withAnimation {
                                // 드래그가 끝나면 멈출 높이에 따라 오프셋 업데이트
                                if dragOffset.height > -cardMaxHeight * 0.5 {
                                    stoppedOffset = 0
                                    isShowingDeleteIcon = false
                                } else if dragOffset.height < -cardMaxHeight {
                                    stoppedOffset = -cardMaxHeight
                                    isShowingDeleteIcon = true
                                }
                                dragOffset = .zero
                            }
                        }
                )
                .animation(.spring())
        }
        .confirmationDialog("카드를 삭제 하시겠습니까?\n카드 속 모든 정보가 ME DROP에서 제거됩니다.", isPresented: $isDelete, titleVisibility: .visible
        ) {
            Button("카드 삭제", role: .destructive) {
                isDelete.toggle()
                cards.removeAll { $0.id == card.id }
                PreferenceManager.myCards = cards
            }
            Button("취소", role: .cancel) {
                isDelete.toggle()
                isShowingDeleteIcon.toggle()
                stoppedOffset = 0
            }
        }
    }
}

struct DeletableCardView_Previews: PreviewProvider {
    static var previews: some View {
        DeletableCardView(card: .constant(ProfileCardModel.sampleData[1]), cards: .constant(ProfileCardModel.sampleData))
    }
}
