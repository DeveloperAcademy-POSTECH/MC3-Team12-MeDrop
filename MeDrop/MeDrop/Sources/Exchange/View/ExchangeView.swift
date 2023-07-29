//
//  ShareView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import Foundation
import SwiftUI

struct ExchangeView: View {
    @ObservedObject var mpc = MpcManager(data: ExchangeDataModel(userName: "ㅈㄷㅂㄷ", team: "소속2", job: "디자이너", cardInfo: "hhh"))
    
    var body: some View {
        ZStack {
            DesignSystemAsset.white2.ignoresSafeArea()
            
            loadingView()
           // requestView()
            //receiveCardView()
            //.ignoresSafeArea()
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

extension ExchangeView {
    @ViewBuilder
    private func yellowJellySpeachView(spacing: CGFloat = 20, text: String, fontSize:CGFloat = 12, textColor:Color = .black) -> some View {
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
                HStack(spacing: 16) {
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
                    
                    TmpCardView(card: ProfileCardModel(name: "젤리빈", contact: "010-0000-0000", company: "􀣺 jelly Developer Academy", job: "Designer.", introduction: "한 줄 소개; 젤리빈 어쩌구 저쩌구", email: "jellyBeen@gmail.com", link: "jellyBeen.com", color: [0.4, 0.5, 0.2]))
                        
                        
                    
                    Button {
                        DEBUG_LOG("저장하기")
                    } label: {
                        Text("저장하기")
                            .font(.bold(17))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)

                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(DesignSystemAsset.yellow2))
                }
                .padding(.horizontal, 20)
                 
               Spacer()
            }
            .padding(.top, safeArea.top)
            .padding(.bottom,safeArea.bottom)
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
    
    @ViewBuilder
    private func requestView() -> some View {
        
        VStack(spacing: 50) {
            VStack(spacing: 30){
                Text("\(mpc.alertUserName)님에게 교환 요청이 왔어요!\n교환을 시작할까요?")
                    .foregroundColor(DesignSystemAsset.white1)
                    .font(.heavy(24))
                
                Image(DesignSystemAsset.Jelly.requestJelly.rawValue)
            }
            
            HStack(spacing: 20) {
                
                Button {
                    
                } label: {
                    Text("거절하기")
                        .font(.bold(17))
                        .foregroundColor(DesignSystemAsset.mainRed)
                }
                .padding(.vertical,15)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(DesignSystemAsset.white1)
                    
                }
                
                Button {
                    
                } label: {
                    Text("수락하기")
                        .font(.bold(17))
                        .foregroundColor(DesignSystemAsset.mainBlue)
                }
                .padding(.vertical,15)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(DesignSystemAsset.white1)
                    
                }

            }
            .padding(.horizontal,20)
        }
        
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        
        VStack{
            Text("교환 수락을 기다리는 중...")
                .font(.bold(24))
                .foregroundColor(.white)
            LottieView(jsonName: "MEDROP",loopMode: .loop) { _ in
                
            }
            VStack(spacing: 0) {
                Text("교환할 상대의 기기와 맞닿아 주세요.")
                    .foregroundColor(.black)
                    .font(.bold(15))
                Text("주변에 같은 무선인터넷을 이용하는 사람이 많다면\n로딩이 길어질 수 있습니다.")
                    .foregroundColor(.black)
                    .font(.regular(15))
                    .multilineTextAlignment(.center)
            }
        }
        
        
    }
}

struct TmpCardView: View {
    var card: ProfileCardModel
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .shadow(radius: 10)
                .padding()
                .overlay(
                    VStack {
                        Spacer()
                        Image("\(card.type)")
                            .renderingMode(.template)
                            .foregroundColor(Color(.sRGB, red: card.color[0], green: card.color[1], blue: card.color[2]))
                            .padding()
                            .border(.black)
                        Spacer()
                        Text("\(card.introduction)")
                        Text("\(card.name)")
                        Text("\(card.company)")
                        Text("\(card.job)")
                        Text("\(card.contact)")
                        Spacer()
                    }
                        .padding()
                        .foregroundColor(.black)
                )
                .foregroundColor(.white)
        }
    }
}
