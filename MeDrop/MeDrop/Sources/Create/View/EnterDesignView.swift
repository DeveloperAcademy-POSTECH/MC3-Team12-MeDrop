//
//  EnterDesignView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/08/01.
//

import SwiftUI

struct EnterDesignView: View {
    @Binding var navigationControl: Int
    @Binding var editingCard: ProfileCardModel
    @Binding var originCard: ProfileCardModel
    @State var selectedDesign = 0
    @Binding var cards: [ProfileCardModel]
    var isCreate: Bool
    @State var color: String = "0"
    
    @State var isBack = false
    @Environment(\.dismiss) private var dismiss
    
    let designImage = [["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""]]
    var body: some View {
        NavigationView {
            
            VStack {
                CarouselDesignView(card: $editingCard, activeIndex: $selectedDesign, color: $color)

                HStack {
                    ForEach(0..<5) { index in
                        Button(action: {
                            
                            editingCard.designType = "\(selectedDesign)-\(index)"
                            color = String(index)
                            
                        }) {
                            Image("\(selectedDesign)-\(index)")
                                .resizable()
                                .scaledToFill()
                                .frame(height: UIScreen.height * 0.06)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                
                        }
                    }
                }.padding(.horizontal)
                HStack {
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.2)){
                            navigationControl -= 1 }}
                    ) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 0.96, green: 0.95, blue: 0.91))
                            Text("이전")
                                .font(Font.custom("SF Pro Text", size: 17))
                                .foregroundColor(DesignSystemAsset.gray3)
                        }
                    }
                    
                    Button(action: { withAnimation(.easeIn(duration: 0.2)){
                        originCard = editingCard
                        if isCreate {
                            cards.append(originCard)
                        }
                        dismiss()
                    }}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(red: 0.33, green: 0.38, blue: 0.54))
                            Text("완료")
                                .font(Font.custom("SF Pro Text", size: 17))
                                .foregroundColor(DesignSystemAsset.white1)
                        }
                    }
                }
                .frame(height: UIScreen.height * 0.07)
                .padding()
                .alert("돌아가시겠어요?", isPresented: $isBack) {
                    Button("확인", role: .destructive) {
                        dismiss()
                    }
                    Button("취소", role: .cancel) {
                        isBack = false
                    }
                } message: {
                    Text("지금 돌아간다면 정보는 저장되지 않습니다. ")
                }
            }
            .onAppear {
                selectedDesign = editingCard.designType.first?.wholeNumberValue ?? 0
            }
            .navigationTitle("명함 디자인을 설정하세요")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            isBack.toggle()
                        }) {
                            Image("x").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.width*0.04, height: UIScreen.height * 0.04)
                            .foregroundColor(.black)
                            .padding()
                        }
                    }
                }.alert("돌아가시겠어요?", isPresented: $isBack) {
                    Button("확인", role: .destructive) {
                        // 정보 저장 없이 돌아가기
                        dismiss()
                    }
                    Button("취소", role: .cancel) {
                        isBack.toggle()
                    }
                } message: {
                    Text("지금 돌아간다면 정보는 저장되지 않습니다. ")
                }
        }
    }
}

struct EnterDesignView_Previews: PreviewProvider {
    static var previews: some View {
        EnterDesignView(navigationControl: .constant(2), editingCard: .constant(ProfileCardModel.emptyCard), originCard: .constant(ProfileCardModel.sampleData[0]), cards: .constant(ProfileCardModel.sampleData), isCreate: true)
    }
}
