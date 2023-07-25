//
//  MeDropApp.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/03.
//

import SwiftUI

@main
struct MeDropApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var dele        
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
