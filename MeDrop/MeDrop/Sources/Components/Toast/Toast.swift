//
//  Toast.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/30.
//

import SwiftUI

enum ToastStyle {
    case error
    case warning
    case success
    case info
    case exchange
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        case .exchange: return Color.black
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .exchange: return "ToastImage"
        }
    }
}

struct Toast: Equatable {
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double = 2
}
