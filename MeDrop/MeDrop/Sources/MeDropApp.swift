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
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            MyCardTest(cards: ProfileCardModel.sampleData)
//                                    .onAppear{
//                                        for family in UIFont.familyNames {
//                                                    print(family)
//
//                                                    for names in UIFont.fontNames(forFamilyName: family) {
//                                                        print("== \(names)")
//                                                    }
//                                        }
//                                    }
        }
    }
}
