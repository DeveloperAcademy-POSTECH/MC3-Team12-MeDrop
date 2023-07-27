//
//  CardStore.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/22.
//

import SwiftUI

class CardStore: ObservableObject {
    @Published var myCards: [ProfileCardModel] = []
    @Published var yourCards: [ProfileCardModel] = []
    @Published var myCardIds: [String] = []
    @Published var yourCardIds: [String] = []
    
    func loadCardIds(for userID: String) {
        myCards = []
        print("loadCardIds Start")
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_")
        let sanitizedUserID = userID.components(separatedBy: allowedCharacters.inverted).joined()
        
        let usersRef = FireBaseDataBaseManager.shared.child("users")
        
        // Fetch the data for the given user ID
        usersRef.child(sanitizedUserID).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            
            if let userData = snapshot.value as? [String: Any],
               let myCardIds = userData["myCards"] as? [String],
               let yourCardIds = userData["yourCards"] as? [String] {
                self.myCardIds = myCardIds
                self.yourCardIds = yourCardIds
                
                // Load and add myCards
                self.fetchAndAddCards(for: myCardIds)
                
                // Load and add yourCards
//                self.fetchAndAddCards(for: yourCardIds)
            } else {
                // User data or card IDs not found, set the arrays to empty
                self.myCardIds = []
                self.yourCardIds = []
            }
        }
    }
    
    private func fetchAndAddCards(for cardIds: [String]) {
        print("fetch Start")
        let cardsRef = FireBaseDataBaseManager.shared.child("cards")
        
        // DispatchGroup 생성
        let dispatchGroup = DispatchGroup()
        
        for cardID in cardIds {
            // DispatchGroup에 enter() 호출
            dispatchGroup.enter()
            
            cardsRef.child(cardID).observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    // 데이터가 존재하는 경우
                    if let cardDataString = snapshot.value as? String,
                       let cardData = cardDataString.data(using: .utf8) {
                        do {
                            let decoder = JSONDecoder()
                            let profileCard = try decoder.decode(ProfileCardModel.self, from: cardData)
                            
                            DispatchQueue.main.async {
                                self.myCards.append(profileCard)
                            }
                        } catch {
                            print("Error decoding card data: \(error)")
                        }
                    } else {
                        print("No card data found or invalid data format.")
                    }
                } else {
                    // 해당 cardID에 해당하는 데이터가 없는 경우
                    print("No data found for cardID: \(cardID)")
                }
                
                // DispatchGroup에 leave() 호출
                dispatchGroup.leave()
            }
        }
        
        // 모든 비동기 작업이 완료될 때까지 기다립니다.
        dispatchGroup.notify(queue: .main) {
            // 모든 데이터를 가져온 후에 실행되는 코드
            print("All data fetched")
        }
    }
}
