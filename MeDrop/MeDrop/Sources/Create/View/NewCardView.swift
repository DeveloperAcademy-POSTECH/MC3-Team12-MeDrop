////
////  NewCardView.swift
////  MeDrop
////
////  Created by SY AN on 2023/07/24.
////
//
//import SwiftUI
//
//struct NewCardView: View {
//    @State private var newCard = ProfileCardModel.emptyCard
//    @State var isShowingColorSelectView: Bool = false
//    @Binding var cards: [ProfileCardModel]
//    @Binding var isFinish: Bool
//    
//    @State var isNotCompleted: Bool = false
//    @State var isNotSaved: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            CardInfoView(card: $newCard, isFinish: $isFinish, isShowingColorSelectView: $isShowingColorSelectView)
//                .navigationTitle("프로필 제작")
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .confirmationAction) {
//                        Button("다음") {
////                            isNotCompleted.toggle()
//                            
//                            if newCard.complete() {
//                                isShowingColorSelectView.toggle()
//                            } else {
//                                isNotCompleted = true
//                            }
//                        }
//                    }
//                    
//                    ToolbarItem(placement: .cancellationAction) {
//                        Button("취소") {
//                            isNotSaved.toggle()
//                        }
//                    }
//                }
//                .alert("돌아가시겠어요?", isPresented: $isNotSaved) {
//                    Button("확인", role: .destructive) {
//                        // 정보 저장 없이 돌아가기
//                        isFinish.toggle()
//                    }
//                    Button("취소", role: .cancel) {
//                        isNotSaved = false
//                    }
//                } message: {
//                    Text("지금 돌아간다면 정보는 저장되지 않습니다. ")
//                }
//                .alert("필수입력란이 채워지지 않았어요", isPresented: $isNotCompleted) {
//                    Button("확인", role: .cancel) {}
//                } message: {
//                    Text("필수 입력 정보를 채워주세요. ")
//                }
//                .navigationDestination(isPresented: $isShowingColorSelectView) {
//                    ColorSelectView(card: $newCard, isFinish: $isFinish)
//                        .navigationTitle("프로필 제작")
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .confirmationAction) {
//                                Button("완료") {
//                                    cards.append(newCard)
//                                    isFinish.toggle()
//                                }
//                            }
//                        }
//                }
//        }
//    }
//}
//
//struct NewCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewCardView(cards:.constant( ProfileCardModel.sampleData), isFinish: .constant(false))
//    }
//}
