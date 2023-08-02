//
//  ShareView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import Foundation
import SwiftUI

struct ExchangeView: View {
    
    @ObservedObject var viewModel:ExchangeViewModel
    @Binding var selectedTab: Tab
    @State var showSheet:Bool = false
    init(card:ProfileCardModel,tab:Binding<Tab>){
        self._viewModel = ObservedObject.init(initialValue: ExchangeViewModel(data: card))
        self._selectedTab = tab
    }
    
    var bottomBar: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Spacer()
            ForEach(tabItems) { tabItem in
                if tabItem.type == .tabType {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selectedTab = tabItem.tab!
                        } }) {
                        VStack(spacing: 0) {
                            Image(systemName: tabItem.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                            Text(tabItem.text)
                                .font(Font.custom("SF Pro Text", size: 11))
                        }.foregroundColor(selectedTab == tabItem.tab ? .black : .secondary)} }
                else {
                    Image("ExchangeMenu_Black")
                        .resizable()
                        .frame(width: UIScreen.width * 0.15, height: UIScreen.width * 0.15)
                        .scaledToFit()
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                        .offset(y: -UIScreen.height * 0.05)
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }        .frame(height: UIScreen.height * 0.1, alignment: .top)
        }
    

    
    var body: some View {
                    
                ZStack {
                    Group{
                        if viewModel.connectedPeers.isEmpty {
                            
                            exchangePlaceHolderView(text: "교환을 할 수 있는 유저가 없어요.\n상대방도 미드랍 앱을 켜면 교환이 가능해요", fontSize: 17)
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
                            LoadingView()
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
                    .zIndex(1)
                    
                    VStack{
                        Spacer()
                        TabClipperShape(radius: 38.0)
                            .fill(Color(.white))
                            .frame(height: UIScreen.height * 0.1, alignment: .top)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                            .overlay(bottomBar)
                    }
                    
                }
            .padding(.top,safeArea.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DesignSystemAsset.white2)
        .toastView(toast: $viewModel.toast)
        .sheet(isPresented: $showSheet) {
            firstExchangeConractView()
        }
        .onAppear{
            showSheet = PreferenceManager.firstExchange!
        }
    }
}

extension ExchangeView {
    @ViewBuilder
    private func exchangePlaceHolderView(spacing: CGFloat = 20, text: String, fontSize:CGFloat = 12, textColor:Color = DesignSystemAsset.blue3) -> some View {
        VStack(spacing: spacing) {
            Text(text)
                .foregroundColor(textColor)
                .font(.bold(fontSize))
                .kerning(-0.32) // 자간 조정
                .lineSpacing(10)
        }
    }
    
    @ViewBuilder
    private func advertiserList() -> some View {
        VStack(spacing:0) {
            
            VStack(spacing:16){
                Text("교환하기")
                    .font(.bold(17))
                    .foregroundColor(.black)
                    
                
                exchangePlaceHolderView(text: "카드를 교환할 사람을 선택해주세요.",fontSize: 13)
            }
           
            
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
                

                VStack(spacing: 30) {
                    
                    
                    CardView(card: viewModel.data)
                        
                        
                    
                    Button {
                        viewModel.save()

                    } label: {
                        Text("완료")
                            .font(.bold(17))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)

                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(DesignSystemAsset.btBeige))
                }
                .padding(.top,safeArea.top)
                .padding(.bottom,120)
                .padding(.horizontal, 45)
                 
            
            

        
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
                Text("\(viewModel.alertUserName)님에게\n교환을 시작할까요?")
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

            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(DesignSystemAsset.blue4))
            
            Button {
                PreferenceManager.firstExchange = true
                showSheet = false
                viewModel.invalidate()
                selectedTab = .my  
            } label: {
                Text("취소하기")
                    .foregroundColor(DesignSystemAsset.btBlue)
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
                        Image("\(card.designType)_background")
                            .renderingMode(.template)
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

struct LoadingView: View {
    
    @State var loadingText: [String] = "MEDROP".map{String($0)}
    @State private var counter:Int = 0
    
    private let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    var body: some View{
        VStack(spacing:20){
            
            Text("상대방의 응답을 기다리고 있어요.")
                .font(.bold(24))
                .foregroundColor(.white)
                .padding(.bottom,30)
            Image("Logo")
                .resizable()
                .scaledToFill()
                .frame(width:200,height: 200)
            
            HStack(spacing:0){
                ForEach(loadingText.indices){ index in
                    Text(loadingText[index])
                        .font(.heavy(28))
                        .foregroundColor(.white)
                        .offset(y:counter == index ? -10 :0)
                    
                }
            }
            .transition(.scale.animation(.easeIn))
            .onReceive(timer) { _ in
                withAnimation(.spring()) {
                    
                    let lastIndex = loadingText.count - 1
                    
                    if counter == lastIndex {
                        counter = 0
                        
                    } else {
                        counter += 1
                    }
                }
            }
        }
}

}
