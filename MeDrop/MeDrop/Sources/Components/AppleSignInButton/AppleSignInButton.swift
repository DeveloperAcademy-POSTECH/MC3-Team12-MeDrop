//
//  AppleSigninButton.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct AppleSignInButton: View {
    var body: some View {
        SignInWithAppleButton { requset in
            requset.requestedScopes = [.fullName, .email]
        } onCompletion: { result  in
            switch result {
            case .success(let authResults):
                
                switch authResults.credential {
                case let appleIDCretential as ASAuthorizationAppleIDCredential:
                    
                    let user = appleIDCretential.user
                    DEBUG_LOG(user)
                    
                default:
                    break
                }
                
            case .failure(let error):
                
                DEBUG_LOG(error.localizedDescription)
            }
        }
    }
}
