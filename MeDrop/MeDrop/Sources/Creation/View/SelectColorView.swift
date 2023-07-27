//
//  SelectColorView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import Firebase
import SwiftUI

struct SelectColorView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var profileCard: ProfileCardModel
    @Binding var sheetTitle: String
    
    @State private var bgColor : Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
    @Binding var isShowingSheet: Bool
    
    @State private var move = false
    @State private var degree = 0.0
    
    var ref: DatabaseReference! = FireBaseDataBaseManager.shared
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("안내문구2").font(.largeTitle).bold().padding()
                HStack {
                    Spacer()
                    HStack {
                        Text("색상")
                        ColorPicker("", selection: $bgColor).labelsHidden()
                            .scaleEffect(CGSize(width: 1.5, height: 1.5))
                            .padding()
                    }
                }

                VStack {
                    Image(systemName: "lanyardcard").font(.system(size: 300))
                        .foregroundColor(bgColor)
                        .shadow(radius: 5)
                        .rotation3DEffect(.degrees(Double(move ? 6 : -6)), axis: (x: CGFloat(move ? 90 : -45), y: CGFloat(move ? -45 : -90), z: 0.0))
                        .animation(.easeInOut.speed(0.2).repeatForever(), value: move)
                        .onAppear {
                            move.toggle()
                        }
                    
                    HStack {
                        Button(action: { profileCard.type = 0 }, label: {
                            ZStack {
                                Circle().foregroundColor(Color.white)
                                Image("0")
                                .renderingMode(.template)
                                .foregroundColor(bgColor)
                            }
                        })
                        
                        Button(action: { profileCard.type = 1 }, label: {
                            ZStack {
                                Circle().foregroundColor(Color.white)
                                Image("1")
                                .renderingMode(.template)
                                .foregroundColor(bgColor)
                            }
                        })
                        
                        Button(action: { profileCard.type = 2 }, label: {
                            ZStack {
                                Circle().foregroundColor(Color.white)
                                Image("2")
                                .renderingMode(.template)
                                .foregroundColor(bgColor)
                            }
                        })
                        
                        Button(action: { profileCard.type = 3 }, label: {
                            ZStack {
                                Circle().foregroundColor(Color.white)
                                Image("3")
                                .renderingMode(.template)
                                .foregroundColor(bgColor)
                            }
                        })
                        
                        Button(action: { profileCard.type = 4 }, label: {
                            ZStack {
                                Circle().foregroundColor(Color.white)
                                Image("4")
                                .renderingMode(.template)
                                .foregroundColor(bgColor)
                            }
                        })
                    }
                    
                    .shadow(color: .gray, radius: 3).padding()
                }
            }
        }
           
        .navigationTitle(sheetTitle)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("이전") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("완료") {
                        profileCard.color = bgColor.cgColor!.components!
                        if let encoded = try? JSONEncoder().encode(profileCard) {
                            if let json = String(data: encoded, encoding: .utf8) {
                                print(json)
                                self.ref.child("cards/\($profileCard.id)").setValue(json)
                            }
                        }
                        isShowingSheet.toggle()
                    }
                }
            } // toolbar end
    }
}

struct SelectColorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectColorView(profileCard: .constant(ProfileCardModel.sampleData[0]), sheetTitle: .constant("프로필 만들기"), isShowingSheet: .constant(true))
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
 
            Spacer()
 
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
