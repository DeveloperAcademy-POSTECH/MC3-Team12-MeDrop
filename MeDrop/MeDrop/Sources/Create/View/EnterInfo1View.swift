//
//  EnterInfo1View.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI

struct EnterInfo1View: View {
    @Binding var navigationControl: Int
    @Binding var editingCard: ProfileCardModel
    @Binding var originCard: ProfileCardModel
    
    @State var isBack = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("이름")
                        .font(
                        Font.custom("SF Pro Text", size: 17)
                        .weight(.bold)
                        )
                    VStack {
                        HStack {
                            TextField("이름/닉네임 모두 가능해요.", text: $editingCard.name.max(8))
                                .font(Font.custom("SF Pro Text", size: 17))

                            Spacer()
                            Text("\($editingCard.name.wrappedValue.count)/8").foregroundColor(.gray)
                                .font(Font.custom("SF Pro Text", size: 13))
                        }
                        Rectangle()
                            .frame(height: 1)
                    } .foregroundColor(DesignSystemAsset.gray1)
                }.padding()
                VStack(alignment: .leading) {
                    Text("소속").font(
                        Font.custom("SF Pro Text", size: 17)
                        .weight(.bold)
                        )
                    VStack {
                        HStack {
                            TextField("회사, 학교, 단체 등을 입력해주세요.", text: $editingCard.company)
                                .font(Font.custom("SF Pro Text", size: 17))
                            Spacer()
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }.foregroundColor(DesignSystemAsset.gray1)
                }.padding()
                VStack(alignment: .leading) {
                    Text("직무").font(
                        Font.custom("SF Pro Text", size: 16)
                        .weight(.bold)
                        )
                    VStack {
                        HStack {
                            TextField("", text: $editingCard.job.max(16))
                                .font(Font.custom("SF Pro Text", size: 16))

                            Spacer()
                            Text("\($editingCard.job.wrappedValue.count)/16").foregroundColor(.gray)
                                .font(Font.custom("SF Pro Text", size: 13))
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }.foregroundColor(DesignSystemAsset.gray1)
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("핸드폰 번호").font(
                        Font.custom("SF Pro Text", size: 17)
                        .weight(.bold)
                        )
                    VStack {
                        HStack {
                            
                            NumberPhoneMaskView(text: $editingCard.contact.max(13)).keyboardType(.numberPad)
                                .font(Font.custom("SF Pro Text", size: 17))
                            Spacer()
                        }
                        Rectangle()
                            .frame(height: 1)
                            
                    }.foregroundColor(DesignSystemAsset.gray1)
                }.padding()
                
                Spacer()
                
                
                HStack {
                    
                    Button(action: {}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(DesignSystemAsset.white2)
                            Text("이전")
                                .font(Font.custom("SF Pro Text", size: 17))
                                .foregroundColor(DesignSystemAsset.gray2)
                        }
                    }.disabled(true)
                    
                    Button(action:
                            {
                        withAnimation(.easeIn(duration: 0.2)){
                            navigationControl += 1   
                        }}) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(editingCard.complete() && editingCard.contact.count == 13 ? Color(red: 0.33, green: 0.38, blue: 0.54) : DesignSystemAsset.white2)
                                Text("다음")
                                    .font(Font.custom("SF Pro Text", size: 17))
                                    .foregroundColor(DesignSystemAsset.white1)
                            }
                            }.disabled(editingCard.complete() && editingCard.contact.count == 13
                                       ? false : true)
                }
                .frame(height: UIScreen.height * 0.07)
                .padding()
            }.navigationTitle("필수 정보를 입력해주세요.")
            
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            isBack.toggle()
                        }) {
                            Image("x").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.width*0.04, height: UIScreen.height * 0.04)
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
        EnterInfo1View(navigationControl: .constant(0), editingCard: .constant(ProfileCardModel.sampleData[0]), originCard: .constant(ProfileCardModel.sampleData[0]))
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
            TextField ("010-0000-0000", text: textChangedBinding)
            .onChange(of: text ) { _ in
                print(text)
    }
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
                result.append(numbers [index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
//            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
//            }
        }
        return self
    }
}
