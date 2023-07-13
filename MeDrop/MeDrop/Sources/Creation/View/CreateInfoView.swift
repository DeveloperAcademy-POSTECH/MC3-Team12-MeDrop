//
//  CreateInfoView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import SwiftUI

struct CreateInfoView: View { 
    @EnvironmentObject var myCards: EnvironmentData
   
    @Binding var showingCreation: Bool
    
    @State var profileCard: ProfileCardModel = ProfileCardModel()
    
    @State var notCompleted: Bool = false
    @State var notSaved: Bool = false
    
    @State var gotoNext: Bool = false
    var textLimit: Int = 100
    
    var body: some View {
        NavigationView {
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
                }
                NavigationLink("", destination: SelectColorView(profileCard: profileCard, showingCreation: $showingCreation), isActive: $gotoNext).environmentObject(myCards)
            }.navigationBarTitle(Text("프로필 제작"), displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("돌아가기") {
                            if profileCard.back() {
                                notSaved = true
                            } else {
                                showingCreation.toggle()
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("다음") {
                            if profileCard.complete() {
                                gotoNext = true
                            } else {
                                notCompleted = true
                            }
                        }
                    }
                }
                .alert("돌아가시겠어요?", isPresented: $notSaved) {
                    Button("확인", role: .destructive) { // 정보 저장 없이 돌아가기
                        showingCreation.toggle()
                    }
                    Button("취소", role: .cancel) {
                        notSaved = false
                    }
                } message: {
                    Text("지금 돌아간다면 정보는 저장되지 않습니다. ")
                }
                .alert("필수입력란이 채워지지 않았어요", isPresented: $notCompleted) {
                    Button("확인", role: .cancel) {}
                } message: {
                    Text("필수 입력 정보를 채워주세요. ")
                }
        }
    }
}
struct CreateInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CreateInfoView(showingCreation: .constant(true)).environmentObject(EnvironmentData())
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
