//
//  CardInfoView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/23.
//

import SwiftUI

struct CardInfoView: View {
    // 보여줄 정보 담긴 카드
    @Binding var card: ProfileCardModel
    @Binding var isFinish: Bool
    @Binding var isShowingColorSelectView: Bool
    
    var textLimit: Int = 100
    
    var body: some View {
        NavigationStack {
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
                                
                            TextField("", text: $card.name)
                        }
                        HStack {
                            HStack {
                                Text("연락처").foregroundColor(Color.gray)
                                Spacer()
                            }
                                .frame(width: UIScreen.width * 0.2)
                            TextField("010-0000-0000", text: $card.contact).keyboardType(.numberPad)
                        }
                        HStack {
                            HStack {
                                Text("소속").foregroundColor(Color.gray)
                                Spacer()
                            }
                                .frame(width: UIScreen.width * 0.2)
                            TextField("", text: $card.company)
                        }
                        HStack {
                            HStack {
                                Text("직업").foregroundColor(Color.gray)
                                Spacer()
                            }
                                .frame(width: UIScreen.width * 0.2)
                            TextField("", text: $card.job)
                        }
                        HStack {
                            HStack {
                                Text("한 줄 소개").foregroundColor(Color.gray)
                                Spacer()
                            }
                                .frame(width: UIScreen.width * 0.2)
                            
                            TextField("", text: $card.introduction.max(textLimit), axis: .vertical)
                        }
                    }
                    Section(header: Text("추가 정보")) {
                        HStack {
                            HStack {
                                Text("이메일").foregroundColor(Color.gray)
                                Spacer()
                            }
                                .frame(width: UIScreen.width * 0.2)
                            TextField("", text: $card.email)
                        }
                        HStack {
                            HStack {
                                Text("대표 링크").foregroundColor(Color.gray)
                                Spacer()
                            }
                                .frame(width: UIScreen.width * 0.2)
                            TextField("", text: $card.link)
                        }
                    }
                    Section(header: Text("SNS 계정")) {
                        HStack {
                            Text("인스타그램").foregroundColor(.gray)
                            TextField("", text: $card.insta)
                        }
                        HStack {
                            Text("트위터").foregroundColor(.gray)
                            TextField("", text: $card.twitter)
                        }
                        HStack {
                            Text("깃헙").foregroundColor(.gray)
                            TextField("", text: $card.github)
                        }
                        HStack {
                            Text("링크드인").foregroundColor(.gray)
                            TextField("", text: $card.linkedin)
                        }
                        HStack {
                            Text("유튜브").foregroundColor(.gray)
                            TextField("", text: $card.youtube)
                        }
                    }
                }
                .background(Color.clear)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView (card: .constant(ProfileCardModel.emptyCard), isFinish: .constant(false), isShowingColorSelectView: .constant(false))
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
