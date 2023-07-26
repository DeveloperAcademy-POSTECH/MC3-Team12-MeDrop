//
//  CreateInfoView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import SwiftUI

struct CreateInfoView: View { 
    @EnvironmentObject var myCards: EnvironmentData
   
    @Binding var isShowingSheet: Bool
    
    @Binding var profileCard: ProfileCardModel
    @Binding var sheetTitle: String
    
    @State var isNotCompleted: Bool = false
    @State var isNotSaved: Bool = false
    
    @State var isGotoNext: Bool = false
    var textLimit: Int = 100
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("안내문구2").font(.largeTitle).bold().padding()
                    Form {
                        Section(header: Text("필수 정보*").foregroundColor(.red)) {
                           
                            HStack {
                                HStack {
                                    Text("이름").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                    .frame(width: UIScreen.width * 0.2)
                                    
                                
                                TextField("", text: $profileCard.name)
                            }
                            HStack {
                                HStack {
                                    Text("연락처").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                    .frame(width: UIScreen.width * 0.2)
                                TextField("010-0000-0000", text: $profileCard.contact).keyboardType(.numberPad)
                            }
                            HStack {
                                HStack {
                                    Text("소속").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                    .frame(width: UIScreen.width * 0.2)
                                TextField("", text: $profileCard.company)
                            }
                            HStack {
                                HStack {
                                    Text("직업").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                    .frame(width: UIScreen.width * 0.2)
                                TextField("", text: $profileCard.job)
                                    
                            }
                            HStack {
                                HStack {
                                    Text("한 줄 소개").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                    .frame(width: UIScreen.width * 0.2)
                                
                                TextField("", text: $profileCard.introduction.max(textLimit), axis: .vertical)
                                    
                            }
                        }
                        
                        Section(header: Text("추가 정보")) {
                            HStack {
                                HStack {
                                    Text("이메일").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                    .frame(width: UIScreen.width * 0.2)
                                TextField("", text: $profileCard.email)
                                    
                            }
                            HStack {
                                HStack {
                                    Text("대표 링크").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                    .frame(width: UIScreen.width * 0.2)
                                TextField("", text: $profileCard.link)
                                    
                            }
                        }
                        
                        Section(header: Text("SNS 계정"))
                        {
                            HStack {
                                Text("인스타그램").foregroundColor(.gray)
                                TextField("", text: $profileCard.insta)
                                    
                            }
                            HStack {
                                Text("트위터").foregroundColor(.gray)
                                TextField("", text: $profileCard.twitter)
                                    
                            }
                            HStack {
                                Text("깃헙").foregroundColor(.gray)
                                TextField("", text: $profileCard.github)
                                    
                            }
                            HStack {
                                Text("링크드인").foregroundColor(.gray)
                                TextField("", text: $profileCard.linkedin)
                                    
                            }
                            HStack {
                                Text("유튜브").foregroundColor(.gray)
                                TextField("", text: $profileCard.youtube)
                                    
                            }
                        }
                    }
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                }.navigationDestination(isPresented: $isGotoNext) {
                    SelectColorView(profileCard: $profileCard, sheetTitle: $sheetTitle, isShowingSheet: $isShowingSheet).environmentObject(myCards)
                    }
                }.navigationTitle(sheetTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("이전") {
                            if profileCard.back() {
                                isNotSaved = true
                            } else {
                                isShowingSheet.toggle()
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
                        isShowingSheet.toggle()
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
        CreateInfoView(isShowingSheet: .constant(true), profileCard: .constant(ProfileCardModel.sampleData[0]), sheetTitle: .constant("프로필 만들기")).environmentObject(EnvironmentData())
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
