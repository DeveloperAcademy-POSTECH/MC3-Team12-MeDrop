//
//  ProfileViewModel.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//

import Foundation
import SwiftUI

enum ContactButton: String, Identifiable, CaseIterable {
    case phone
    case message
    case mail
    case safari

    var sfSymbol: String {
        switch self {
        case .phone: return "phone.fill"
        case .message: return "message"
        case .mail: return "envelope.fill"
        case .safari: return "safari.fill"
        }
    }

    var labelText: String {
        switch self {
        case .phone: return "Phone"
        case .message: return "Message"
        case .mail: return "Mail"
        case .safari: return "Safari"
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}

@ViewBuilder
func actionButtonDrawer(contactButton: ContactButton, buttonColor: Color, buttonTextColor: Color, profileCard: any ProfileCard) -> some View {
    Button(
        action: {
        switch contactButton {
        case .phone:
            if let url = URL(string: "tel:\(profileCard.contact)") {
                UIApplication.shared.open(url)
            }
            
        case .message:
            if let url = URL(string: "sms:\(profileCard.contact)") {
                UIApplication.shared.open(url)
            }
            
        case .mail:
            if let url = URL(string: "mailto:\(profileCard.email)") {
                UIApplication.shared.open(url)
            }
            
        case .safari:
            if let url = URL(string: "https://\(profileCard.link)") {
                UIApplication.shared.open(url)
            }
        }
    }) {
        VStack(spacing: 2) {
            Image(systemName: contactButton.sfSymbol)
                .tint(.black)
                .font(.system(size: 20))
            Text(contactButton.labelText)
                .font(.semiBold(11))
        }
        .foregroundColor(buttonTextColor)
        .frame(width: 76, height: 66)
        .background(buttonColor)
        .cornerRadius(14)
    }
}
