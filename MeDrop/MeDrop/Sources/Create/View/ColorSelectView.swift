////
////  ColorSelectView.swift
////  MeDrop
////
////  Created by SY AN on 2023/07/24.
////
//
//import SwiftUI
//
//struct ColorSelectView: View {
//    
//    @Binding var card: ProfileCardModel
//    @State private var bgColor : Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
//    @Binding var isFinish: Bool
//    
//    @State private var move = false
//    @State private var degree = 0.0
//    
//    var body: some View {
//        ZStack {
//            VStack(alignment: .leading) {
//                Text("안내문구2").font(.largeTitle).bold().padding()
//                HStack {
//                    Spacer()
//                    HStack {
//                        Text("색상")
//                        ColorPicker("", selection: $bgColor).labelsHidden()
//                            .scaleEffect(CGSize(width: 1.5, height: 1.5))
//                            .padding()
//                    }
//                }
//                
//                VStack {
//                    Image(systemName: "lanyardcard").font(.system(size: 300))
//                        .foregroundColor(bgColor)
//                        .shadow(radius: 5)
//                        .rotation3DEffect(.degrees(Double(move ? 6 : -6)), axis: (x: CGFloat(move ? 90 : -45), y: CGFloat(move ? -45 : -90), z: 0.0))
//                        .animation(.easeInOut.speed(0.2).repeatForever(), value: move)
//                        .onAppear {
//                            move.toggle()
//                        }
//                    
//                    HStack {
//                        Button(action: { card.type = 0 }, label: {
//                            ZStack {
//                                Circle().foregroundColor(Color.white)
//                                Image("0")
//                                    .renderingMode(.template)
//                                    .foregroundColor(bgColor)
//                            }
//                        })
//                        
//                        Button(action: { card.type = 1 }, label: {
//                            ZStack {
//                                Circle().foregroundColor(Color.white)
//                                Image("1")
//                                    .renderingMode(.template)
//                                    .foregroundColor(bgColor)
//                            }
//                        })
//                        
//                        Button(action: { card.type = 2 }, label: {
//                            ZStack {
//                                Circle().foregroundColor(Color.white)
//                                Image("2")
//                                    .renderingMode(.template)
//                                    .foregroundColor(bgColor)
//                            }
//                        })
//                        
//                        Button(action: { card.type = 3 }, label: {
//                            ZStack {
//                                Circle().foregroundColor(Color.white)
//                                Image("3")
//                                    .renderingMode(.template)
//                                    .foregroundColor(bgColor)
//                            }
//                        })
//                        
//                        Button(action: { card.type = 4 }, label: {
//                            ZStack {
//                                Circle().foregroundColor(Color.white)
//                                Image("4")
//                                    .renderingMode(.template)
//                                    .foregroundColor(bgColor)
//                            }
//                        })
//                    }
//                    
//                    .shadow(color: .gray, radius: 3).padding()
//                }
//            }
//        }
//        .onAppear {
//            bgColor = Color(.sRGB, red: card.color[0], green: card.color[1], blue: card.color[2])
//        }
//    }
//}
//
//struct ColorSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorSelectView(card: .constant(ProfileCardModel.emptyCard), isFinish: .constant(false))
//    }
//}
