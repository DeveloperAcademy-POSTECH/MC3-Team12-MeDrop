//
//  ShareView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import Foundation
import SwiftUI

struct ShareView: View {
    @ObservedObject var mpc = MpcManager(data: ShareData(userName: "ㅈㄷㅂㄷ", team: "소속2", cardInfo: "hhh"))
    
    var body: some View {
        ZStack {
            DesignSystemAsset.BackgroundColor.background2.ignoresSafeArea()
            
            if(mpc.connectedPeers.isEmpty)
            {
                yellowJellySpeachView(text: "교환을 할 수 있는 유저가 없어요...\n저희 앱을 추천해 보세요!")
                Button("Start"){
                    mpc.startHosting()
                }
            }
            
            else {
                advertiserList()
            }
            
            
        }
        .alert(isPresented: $mpc.showPermissionAlert) {
            Alert(title: Text("\(mpc.alertUserName)이 맞습니까?"), primaryButton: .default(Text("YES"),action: {
                mpc.sendConnectState()
            }), secondaryButton: .destructive(Text("NO"), action: {
                mpc.sendDeniedState()
            }))
        }
    }
}

extension ShareView {
    @ViewBuilder
    private func yellowJellySpeachView(spacing: CGFloat = 20,text: String) -> some View {
        VStack(spacing: spacing) {
            Image(DesignSystemAsset.Jelly.yellowSmallJelly.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
            
            Text(text)
                .foregroundColor(.black)
                .font(.bold(11))
                .kerning(-0.32) // 자간 조정
                .lineSpacing(10)
        }
    }
    
    @ViewBuilder
    private func advertiserList() -> some View {
        VStack {
            yellowJellySpeachView(text: "누구에게 교환을 요청할까요?")
            
            List(mpc.connectedPeers, id: \.self){ peer in
                let displayName = peer.displayName
                let arr = displayName.split(separator: seperatorString)
                let name: String = String(arr[0])
                let team: String = String(arr[1])
                
                HStack{
                    VStack(alignment: .leading,spacing: 0) {
                        
                        Text(name)
                            .font(.bold(17))
                            .foregroundColor(.black)
                        Text(team)
                            .font(.regular(15))
                            .foregroundColor(DesignSystemAsset.ButtonTextColor.gray2)
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
        .padding(.top,20)
    }
}
