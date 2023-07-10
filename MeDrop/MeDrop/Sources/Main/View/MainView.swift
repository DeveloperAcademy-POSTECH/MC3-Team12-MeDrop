//
//  MainView.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import SwiftUI

struct MainView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MyView()
                .tabItem {
                    Label("My", systemImage: "person.crop.circle.fill")
                }
                .tag(1)
            ChangeView()
                .tabItem {
                    Label("Change", systemImage: "antenna.radiowaves.left.and.right")
                }
                .tag(2)
            CollectView()
                .tabItem {
                    Label("Collect", systemImage: "shared.with.you")
                }
                .tag(3)
        }
        .font(.regular(50))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
