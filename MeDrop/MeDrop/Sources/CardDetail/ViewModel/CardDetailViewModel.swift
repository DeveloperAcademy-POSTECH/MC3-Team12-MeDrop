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


enum SocialMediaLink: String, Identifiable, CaseIterable {
    case link
    case github
    case youtube
    case linkedin
    case twitter
    case instagram

    var text: String {
        switch self {
        case .link: return "link"
        case .github: return "github"
        case .youtube: return "youtube"
        case .linkedin: return "linkedin"
        case .twitter: return "twitter"
        case .instagram: return "instagram"
        }
    }

    var icon: String {
        switch self {
        case .link: return "link"
        case .github: return "github"
        case .youtube: return "youtube"
        case .linkedin: return "linkedin"
        case .twitter: return "twitter"
        case .instagram: return "instagram"
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
