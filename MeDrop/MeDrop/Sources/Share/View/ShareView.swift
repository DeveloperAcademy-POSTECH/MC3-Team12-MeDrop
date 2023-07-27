//
//  ShareView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import Foundation
import SwiftUI

struct ShareView: View {
    @ObservedObject var mpc = MpcManager(data: ShareData(userName: "ㅈㄷㅂㄷ", team: "소속2", job: "디자이너", cardInfo: "hhh", image: "Image1"))
    
    var body: some View {
        ZStack {
            DesignSystemAsset.BackgroundColor.background2.ignoresSafeArea()
            
           
                
            receiveCardView()
                .ignoresSafeArea()
//            if mpc.connectedPeers.isEmpty {
//                yellowJellySpeachView(text: "교환을 할 수 있는 유저가 없어요...\n저희 앱을 추천해 보세요!", fontSize: 17)
//                Button("Start") {
//                    mpc.startHosting()
//                }
//            } else {
//                advertiserList()
//            }
        }
        .alert(isPresented: $mpc.showPermissionAlert) {
            Alert(title: Text("\(mpc.alertUserName)이 맞습니까?"), primaryButton: .default(Text("YES"), action: {
                mpc.sendConnectState()
            }), secondaryButton: .destructive(Text("NO"), action: {
                mpc.sendDeniedState()
            }))
        }
    }
}

extension ShareView {
    @ViewBuilder
    private func yellowJellySpeachView(spacing: CGFloat = 20,text: String,fontSize:CGFloat = 12,textColor:Color = .black) -> some View {
        VStack(spacing: spacing) {
            Image(DesignSystemAsset.Jelly.yellowSmallJelly.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
            
            Text(text)
                .foregroundColor(textColor)
                .font(.bold(fontSize))
                .kerning(-0.32) // 자간 조정
                .lineSpacing(10)
        }
    }
    
    @ViewBuilder
    private func advertiserList() -> some View {
        VStack {
            yellowJellySpeachView(text: "누구에게 교환을 요청할까요?")
            
            List(mpc.connectedPeers, id: \.self) { peer in
                let displayName = peer.displayName
                let arr = displayName.split(separator: seperatorString)
                let name: String = String(arr[0])
                let team: String = String(arr[1])
                let job: String = String(arr[2])
                let img: String = String(arr[3])
                HStack(spacing: 16) {
                    Image(img)
                        .resizable()
                        .scaledToFill()
                        .background(content: {
                            Circle()
                                .foregroundColor(.red)
                                .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                               // .blur(radius: 4,opaque: true) // opaque 투명한 블러를 만들려면 true로 설정하고 투명도를 허용하려면 false로 설정합니다.
                        })
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(name)
                            .font(.bold(17))
                            .foregroundColor(.black)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(team)
                                .font(.regular(14))
                                .foregroundColor(.black)
                            Text(job)
                                .font(.regular(14))
                                .foregroundColor(.black)
                        }
                    }
                    Spacer()
                    
                    Button {
                        mpc.confirmConnectState(id: peer.displayName)
                    } label: {
                        Text("공유하기")
                            .font(.regular(17))
                            .foregroundColor(DesignSystemAsset.mainBlue)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    private func receiveCardView(arcColor: Color = .gray) -> some View {
        ZStack {
            Color.black.opacity(0.6)
               
                
            VStack {
                yellowJellySpeachView(text: "상대방의 명함을 저장해보세요!", textColor: .white)
                    .padding(.top, 20)
                
                    
                
                VStack(spacing: 30) {
                    
                    Text(mpc.receiveCard)
                    HStack(spacing: 20) {
                        
                        Button {
                            DEBUG_LOG("계속하기")
                        } label: {
                            Text("계속하기")
                                .font(.bold(17))
                                .foregroundColor(DesignSystemAsset.mainBlue)
                        }
                        .padding(.horizontal, 48)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.white))
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            DEBUG_LOG("저장하기")
                        } label: {
                            Text("저장하기")
                                .font(.bold(17))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 48)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(DesignSystemAsset.ButtonColor.button8))
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 20)
                .frame(height: 200)
            
                
                    
               Spacer()
            }
            .padding(.top, safeArea.top)
        }
        .background(alignment: .bottom) {
            ArcView()
                .frame(width: UIScreen.width, height: UIScreen.width)
                .foregroundColor(arcColor)
                .edgesIgnoringSafeArea(.bottom)
        }
        
    }
    
    private struct ArcView: Shape {
        
        func path(in rect: CGRect) -> Path {
            Path { path in
                
                let upPos = UIScreen.width / 2 + 10
                
                path.move(to: CGPoint(x: rect.minX, y: rect.maxY)) // 왼쪽 아래
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - upPos ))
                
                path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY -  upPos ), radius: UIScreen.width / 2, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 360), clockwise: false)
                

                
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - upPos))
                
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxX))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxX))
                path.closeSubpath()
               
            }
        }
    }
}