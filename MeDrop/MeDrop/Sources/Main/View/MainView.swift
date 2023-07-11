//
//  MainView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel = .init()
    var body: some View {
        ZStack {
            if !viewModel.isSplashFinished {
                SplashView()
                    .ignoresSafeArea()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                            
                            withAnimation(.easeIn) {
                                viewModel.isSplashFinished.toggle()
                            }
                        })
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
