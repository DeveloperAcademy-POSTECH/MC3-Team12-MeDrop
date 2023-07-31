//
//  EnterDesignView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/08/01.
//

import SwiftUI

struct EnterDesignView: View {
    @Binding var navigationControl: Int
    @Binding var card: ProfileCardModel
    @State var selectedDesign = 0
    @Binding var cards: [ProfileCardModel]
    
    @State var isBack = false
    @Environment(\.dismiss) private var dismiss
    
    let designImage = [["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""]]
    var body: some View {
        NavigationView {
            
            VStack {
                
//                Spacer()
//                Button(action: {
//                    withAnimation(.easeOut(duration: 0.4)) {
//                        selectedDesign += 1
//                    }
//                }) {
//                    Image(systemName: "lanyardcard")
//                }
                
                CustomCarouselView(activeIndex: $selectedDesign)

                HStack {
                    ForEach(0..<5) { index in
                        Button(action: {
                            // MARK: TEMP use introduction to store design selection
                            card.introduction = "\(selectedDesign)-\(index)"
                        }) {
                            Image("\(selectedDesign)-\(index)")
                        }
                    }
                }
                Spacer()
                HStack {
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.2)){
                            navigationControl -= 1 }}
                    ) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(DesignSystemAsset.gray4)
                            Text("이전").foregroundColor(DesignSystemAsset.gray2)
                        }
                    }
                    
                    Button(action: { withAnimation(.easeIn(duration: 0.2)){
                        cards.append(card)
                        dismiss()
                    }}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Text("완료").foregroundColor(.white)
                        }
                    }
                }
                .frame(height: UIScreen.height * 0.07)
                .padding()
                .alert("돌아가시겠어요?", isPresented: $isBack) {
                    Button("확인", role: .destructive) {
                        // 정보 저장 없이 돌아가기
                        dismiss()
                    }
                    Button("취소", role: .cancel) {
                        isBack = false
                    }
                } message: {
                    Text("지금 돌아간다면 정보는 저장되지 않습니다. ")
                }
            }.navigationTitle("명함 디자인 선택 문구")
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
        EnterDesignView(navigationControl: .constant(2), card: .constant(ProfileCardModel.emptyCard), cards: .constant(ProfileCardModel.sampleData))
    }
}
