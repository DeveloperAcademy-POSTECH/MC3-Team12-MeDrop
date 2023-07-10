//
//  Extension+UIApplication.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import SwiftUI
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // 키보드 없애기
    }
    
    func hideKeyboard() {
        if #available(iOS 15, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            
            let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
            tapRecognizer.cancelsTouchesInView = false
            tapRecognizer.delegate = self
            window!.addGestureRecognizer(tapRecognizer)
        } else {
            guard let window = windows.first else { return }
            let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
            tapRecognizer.cancelsTouchesInView = false
            tapRecognizer.delegate = self
            window.addGestureRecognizer(tapRecognizer)
        }
    }
}
     
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            false // set to `false` if you don't want to detect tap during other gestures
    }
}
