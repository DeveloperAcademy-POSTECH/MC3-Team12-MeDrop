//
//  MyView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import Foundation
import SwiftUI

struct MyView: View {
    @StateObject var myViewModel = MyViewModel()
    
    let screenWidth: Double
    let cardWidth: Double
    let cardHeight: Double
    let widthHeightRatio: Double = 8.56 / 5.39
    
    init() {
        self.screenWidth = UIScreen.main.bounds.size.width
        cardWidth = screenWidth - .spacing40 - .spacing10
        cardHeight = cardWidth * widthHeightRatio
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("My Profile")
                    .font(.black(34))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Menu {
                    Button {
                    } label: {
                        Label("Me-Drop", systemImage: "questionmark.app")
                    }
                    Button {
                    } label: {
                        Label("로그아웃", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                    Button(role: .destructive) {
                    } label: {
                        Label("회원 탈퇴", systemImage: "exclamationmark.triangle")
                    }
                } label: {
                    Image(systemName: "list.bullet")
                }
                .font(.regular(20))
                .frame(alignment: .trailing)
            }
            
            carouselContainerView()
            
            Spacer()
        }
        .padding(.top, .spacing40)
        .padding(.horizontal, .spacing20)
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
