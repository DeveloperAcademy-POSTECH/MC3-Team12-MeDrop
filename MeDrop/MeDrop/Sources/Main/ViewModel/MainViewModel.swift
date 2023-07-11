//
//  MainViewModel.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/11.
//

import Foundation
import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    @Published var isSplashFinished: Bool = false
    @Published var id: String? = PreferenceManager.id
    
}
