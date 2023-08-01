//
//  EnterInfo1View.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI

struct EnterInfo1View: View {
    @Binding var navigationControl: Int
    @Binding var card: ProfileCardModel
    
    @State var isBack = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("이름")
                    VStack {
                        HStack {
                            TextField("실명/닉네임 모두 가능해요.", text: $card.name.max(21))

                            Spacer()
                            Text("\($card.name.wrappedValue.count)/20").foregroundColor($card.name.wrappedValue.count > 20 ? .red : .gray) 
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                }.padding()
                VStack(alignment: .leading) {
                    Text("소속")
                    VStack {
                        HStack {
                            TextField("소속을 입력해주세요.", text: $card.company)
                            Spacer()
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                }.padding()
                VStack(alignment: .leading) {
                    Text("직업")
                    VStack {
                        HStack {
                            TextField("직업을 입력해주세요.", text: $card.job.max(21))

                            Spacer()
                            Text("\($card.job.wrappedValue.count)/20").foregroundColor($card.job.wrappedValue.count > 20 ? .red : .gray)
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("연락처")
                    VStack {
                        HStack {
                            
                            NumberPhoneMaskView(text: $card.contact).keyboardType(.numberPad)
                            Spacer()
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                }.padding()
                
                Spacer()
                
                
                HStack {
                    
                    Button(action: {}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Text("이전")
                        }
                    }.disabled(true)
                    
                    Button(action:
                            {
                        withAnimation(.easeIn(duration: 0.2)){
                            navigationControl += 1   
                        }}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Text("다음").foregroundColor(.white)
                        }
                            }.disabled(card.complete() && card.contact.count == 13
                                       ? false : true)
                }
                .frame(height: UIScreen.height * 0.08)
                .padding()
            }.navigationTitle("필수 정보 입력 문구")
            
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

struct EnterInfo1View_Previews: PreviewProvider {
    static var previews: some View {
        EnterInfo1View(navigationControl: .constant(0), card: .constant(ProfileCardModel.sampleData[0]))
    }
}

struct NumberPhoneMaskView: View {
// MARK: Properties
    let maskPhone = "XXX-XXXX-XXXX"
    @Binding var text: String

var body: some View {
    VStack {
        let textChangedBinding = Binding<String>(
            get: {
                FilterNumberPhone.format (with: self.maskPhone, phone: self.text)},
                set: { self.text = $0
                    
                })
            TextField ("010-0000-000", text: textChangedBinding)
            }
            }
        }


class FilterNumberPhone: ObservableObject {
    static func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences (of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append (numbers [index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
