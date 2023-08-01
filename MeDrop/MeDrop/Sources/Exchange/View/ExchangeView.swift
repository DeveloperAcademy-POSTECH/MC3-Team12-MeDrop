//
//  ShareView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import Foundation
import SwiftUI

struct ExchangeView: View {
    
    @ObservedObject var viewModel:ExchangeViewModel = .init(data: ExchangeDataModel(userName: "ㅈㄷㅂㄷ", team: "소속2", job: "디자이너", cardInfo: "hhh"))
//    init(){
//        viewModel = .init(data: ExchangeDataModel(userName: "ㅈㄷㅂㄷ", team: "소속2", job: "디자이너", cardInfo: "hhh"))
//    }
    var bottomBar: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(tabItems) { tabItem in
                Button(action: {
                        withAnimation(.easeInOut) {
                            selectedTab = tabItem.tab!
                        }
                }) {
                    if tabItem.type == .tabType {
                        VStack(spacing: 0) {
                            Image(systemName: tabItem.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                            Text(tabItem.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                    } else {
                        Image(systemName: tabItem.icon).foregroundColor(selectedTab == .my ? .black : .gray).padding()
                            .symbolVariant(.fill)
                            .font(.body.bold())
//                            .foregroundColor(Color.white)
                            .background(Circle().foregroundColor(.white))
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                            
                            .disabled(selectedTab == .your)
                    }
                }
                .offset(y: tabItem.type == .tabType ? 0 : -35)
                .foregroundColor(selectedTab == tabItem.tab ? .black : .secondary)
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(height: 88, alignment: .top)
        .padding(.top, 14)
    }
    
    @Binding var selectedTab: Tab
    @State var showSheet:Bool = false
    
    var body: some View {
                    
            VStack {
                ZStack {
                    DesignSystemAsset.white2.ignoresSafeArea()
                    Group{
                        if viewModel.connectedPeers.isEmpty {
                            
                            yellowJellySpeachView(text: "교환을 할 수 있는 유저가 없어요...\n저희 앱을 추천해 보세요!", fontSize: 17)
                            Button("Start") {
                                viewModel.startHosting()
                            }
                        }
                        
                        else {
                            advertiserList()
                        }
                    }
                    
                    
                    Group{
                        switch viewModel.state {
                            
                        case .request:
                            requestView()
                            
                        case .waiting:
                            loadingView()
                        case .exchange:
                            receiveCardView()
                        case .none:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background {
                        Color.black.opacity(0.8)
                            .ignoresSafeArea()
                    }
                    
                    
                }
                
                TabClipperShape(radius: 38.0)
                    .fill(Color(.white))
                    .frame(height: 88, alignment: .top)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                    .overlay(bottomBar)
                    
                
                
            
        }.edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toastView(toast: $viewModel.toast)
        .sheet(isPresented: $showSheet,onDismiss: {
                  
            if !PreferenceManager.firstExchange! { //만약 닫을 때 동의가 안된 상태면
                //TODO: 내 카드로 이동
            }
        }) {
            firstExchangeConractView()
        }
        .onAppear{
            showSheet = PreferenceManager.firstExchange!
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
            
            List(viewModel.connectedPeers, id: \.self) { peer in
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
                        viewModel.confirmConnectState(id: peer.displayName)
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
                    
                    TmpCardView(card: ProfileCardModel(name: "젤리빈", contact: "010-0000-0000", company: "􀣺 jelly Developer Academy", job: "Designer.", introduction: "한 줄 소개; 젤리빈 어쩌구 저쩌구", email: "jellyBeen@gmail.com", link: "jellyBeen.com"))
                        
                        
                    
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
                Text("\(viewModel.alertUserName)님에게 교환 요청이 왔어요!\n교환을 시작할까요?")
                    .foregroundColor(DesignSystemAsset.white1)
                    .font(.heavy(24))
                
                Image(DesignSystemAsset.Jelly.requestJelly.rawValue)
            }
            
            HStack(spacing: 20) {
                
                Button {
                    viewModel.sendDeniedState()
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
                    viewModel.sendConnectState()
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
    
    @ViewBuilder
    private func firstExchangeConractView() -> some View {
        
        VStack(spacing: 20){
            
            HStack{
                Button {
                    PreferenceManager.firstExchange = true
                    showSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()

            }
            .padding(.top, 20)
            
            Text("교환 시 나오는 개인정보 동의문구")
                .foregroundColor(.black)
                .font(.bold(24))
            
            
            
            
            Spacer()
            Button {
                PreferenceManager.firstExchange = false
                showSheet = false
            } label: {
                Text("동의하기")
                    .foregroundColor(DesignSystemAsset.white1)
                    .font(.heavy(17))
            }
            .padding(.vertical,14)
            .frame(maxWidth: .infinity)

            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(DesignSystemAsset.gray1))
            
            Button {
                PreferenceManager.firstExchange = true
                showSheet = false
            } label: {
                Text("동의안함")
                    .foregroundColor(DesignSystemAsset.gray1)
                    .font(.heavy(17))
            }
            .padding(.vertical,14)
            .frame(maxWidth: .infinity)

            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(DesignSystemAsset.white2))
        }
        .padding(.horizontal,20)
        .presentationDragIndicator(.visible)
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
