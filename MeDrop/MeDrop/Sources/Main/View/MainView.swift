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
                LottieView(jsonName: "MEDROP") { _ in
                    withAnimation {
                        viewModel.isSplashFinished.toggle()
                    }
            }
            } else if viewModel.isSplashFinished && viewModel.id == nil {
                OnBoardView()
            } else {
                MainTabView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
