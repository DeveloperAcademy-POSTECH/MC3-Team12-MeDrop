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
    var subscriptions = Set<AnyCancellable>()

    init() {
        output()
    }
}

extension MainViewModel {
    func output() {
        PreferenceManager.$id
            .assign(to: &$id)
    }
}
