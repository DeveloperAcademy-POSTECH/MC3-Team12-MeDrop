//
//  FireBaseManager.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/08.
//

import Foundation
import Firebase

final class FireBaseDataBaseManager {
    public static let shared = Database.database().reference()
    
    func registerUser() {
        guard let userID = PreferenceManager.id else {
            return
        }
        
        // Remove characters that are not allowed in Firebase Database paths
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_")
        let sanitizedUserID = userID.components(separatedBy: allowedCharacters.inverted).joined()
        print(sanitizedUserID)
        
        // 먼저 users 경로에 빈 데이터를 추가합니다.
        let usersRef = FireBaseDataBaseManager.shared.child("users")
        usersRef.child(sanitizedUserID).setValue(nil) { error, _ in
            
            if let error = error {
                // 데이터 추가 중 오류가 발생한 경우 처리
                print("사용자 데이터 추가 실패: \(error.localizedDescription)")
            } else {
                let ref = usersRef.child(sanitizedUserID)
                let userData: [String: Any] = [
                    "myCards": [],
                    "yourCards": []
                ]
                
                ref.setValue(userData) { error, _ in
                    if let error = error {
                        // 데이터 추가 중 오류가 발생한 경우 처리
                        print("사용자 데이터 추가 실패: \(error.localizedDescription)")
                    } else {
                        print(userData)
                        // 데이터 추가가 성공적으로 완료된 경우 처리
                        print("사용자 데이터 추가 성공")
                    }
                }
            }
        }
    }
}
