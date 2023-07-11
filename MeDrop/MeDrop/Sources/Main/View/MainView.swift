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
            } else if viewModel.isSplashFinished && viewModel.id == nil {
                OnBoardView()
            } else {
                Button("Reset") {
                    withAnimation(.easeIn) {
                        if PreferenceManager.id == nil {
                            PreferenceManager.id = "123"
                        } else {
                            PreferenceManager.id = nil
                        }
                    }
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
