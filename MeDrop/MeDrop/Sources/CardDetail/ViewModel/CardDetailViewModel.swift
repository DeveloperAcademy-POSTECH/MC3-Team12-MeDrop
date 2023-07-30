//
//  CardDetailViewModel.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/26.
//

import SwiftUI

enum ContactButton: String, Identifiable, CaseIterable {
    case phone
    case message
    case mail

    var sfSymbol: String {
        switch self {
        case .phone: return "phone.fill"
        case .message: return "message"
        case .mail: return "envelope.fill"
        }
    }

    var labelText: String {
        switch self {
        case .phone: return "Phone"
        case .message: return "Message"
        case .mail: return "Mail"
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
func actionButtonDrawer(contactButton: ContactButton, profileCard: any ProfileCard) -> some View {
    let isEmailEmpty = profileCard.email.isEmpty
    let isLinkEmpty = profileCard.link.isEmpty
    
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
            }
        }
    ) {
        VStack(spacing: 2) {
            Image(systemName: contactButton.sfSymbol)
                .tint(.black)
                .font(.system(size: 20))
            Text(contactButton.labelText)
                .font(.semiBold(11))
        }
        .foregroundColor(.green)
        .frame(width: 76, height: 60)
        .background(.green)
        .cornerRadius(14)
    }
    .disabled((contactButton == .mail && isEmailEmpty) )
    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
}


@ViewBuilder
func infoRowDrawer(label: String, content: String) -> some View {
    VStack(alignment: .leading) {
        Text("\(label)")
            .font(Font.regular(14))
        Text("\(content)")
            .font(Font.bold(17))
            .padding(.top, 2)
    }
}


enum SocialButton: String, Identifiable, CaseIterable {
    case insta
    case twitter
    case github
    case linkedin
    case youtube

    var sfSymbol: String {
        switch self {
        case .insta: return "phone.fill"
        case .twitter: return "message"
        case .github: return "envelope.fill"
        case .linkedin: return "safari.fill"
        case .youtube: return "safari.fill"
        }
    }

    var labelText: String {
        switch self {
        case .insta: return "Instagram"
        case .twitter: return "Twitter"
        case .github: return "LinkedIn"
        case .linkedin: return "Youtube"
        case .youtube: return "Github"
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}

