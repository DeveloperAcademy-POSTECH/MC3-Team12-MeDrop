//
//  CreateInfoView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import SwiftUI

struct CreateInfoView: View { 
    @EnvironmentObject var myCards: EnvironmentData
   
    @Binding var isShowingCreation: Bool
    
    @State var profileCard: ProfileCardModel = ProfileCardModel()
    
    @State var isNotCompleted: Bool = false
    @State var isNotSaved: Bool = false
    
    @State var isGotoNext: Bool = false
    var textLimit: Int = 100
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Form {
                        VStack(alignment: .leading) {
                            Text("카드에 들어갈")
                            Text("내용을 작성").bold() +
                            Text("해주세요.")
                        }.font(.regular(28))
                            .listRowBackground(Color.clear)
                        
                        Section(header: Text("필수 입력란")) {
                            TextField("이름", text: $profileCard.name)
                            TextField("연락처", text: $profileCard.contact).keyboardType(.numberPad)
                            TextField("소속", text: $profileCard.company)
                            TextField("직업", text: $profileCard.job)
                            TextField("한 줄 소개", text: $profileCard.introduction.max(textLimit), axis: .vertical)
                        }
                        
                        Section(header: Text("선택 입력란")) {
                            TextField("이메일", text: $profileCard.email)
                        }
                    }
                }.navigationDestination(isPresented: $isGotoNext) {
                         SelectColorView(profileCard: profileCard, showingCreation: $isShowingCreation).environmentObject(myCards)
                    }
                }.navigationTitle("프로필 제작")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("돌아가기") {
                            if profileCard.back() {
                                isNotSaved = true
                            } else {
                                isShowingCreation.toggle()
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("다음") {
                            if profileCard.complete() {
                                isGotoNext = true
                            } else {
                                isNotCompleted = true
                            }
                        }
                    }
                }
                .alert("돌아가시겠어요?", isPresented: $isNotSaved) {
                    Button("확인", role: .destructive) { // 정보 저장 없이 돌아가기
                        isShowingCreation.toggle()
                    }
                    Button("취소", role: .cancel) {
                        isNotSaved = false
                    }
                } message: {
                    Text("지금 돌아간다면 정보는 저장되지 않습니다. ")
                }
                .alert("필수입력란이 채워지지 않았어요", isPresented: $isNotCompleted) {
                    Button("확인", role: .cancel) {}
                } message: {
                    Text("필수 입력 정보를 채워주세요. ")
                }
        }
    }
}
struct CreateInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CreateInfoView(isShowingCreation: .constant(true)).environmentObject(EnvironmentData())
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count >= limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
