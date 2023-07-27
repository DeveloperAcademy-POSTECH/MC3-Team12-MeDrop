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
    
    private let myCardsKey = "MyCards"
    private let yourCardsKey = "YourCards"
    
    // 데이터를 UserDefaults에 저장하는 함수
    func saveData() {
        do {
            let myCardsData = try JSONEncoder().encode(myCards)
            UserDefaults.standard.set(myCardsData, forKey: myCardsKey)
            
            let yourCardsData = try JSONEncoder().encode(yourCards)
            UserDefaults.standard.set(yourCardsData, forKey: yourCardsKey)
            
        } catch {
            print("Error encoding cards: \(error)")
        }
    }
    
    // UserDefaults에서 데이터를 로드하는 함수
    func loadData() {
        if let myCardsData = UserDefaults.standard.data(forKey: myCardsKey) {
            do {
                let decodedMyCards = try JSONDecoder().decode([ProfileCardModel].self, from: myCardsData)
                myCards = decodedMyCards
            } catch {
                print("Error decoding myCards: \(error)")
                myCards = getEmptyCardArray() // 데이터가 없을 경우 빈 배열을 설정
            }
        } else {
            myCards = getEmptyCardArray() // 데이터가 없을 경우 빈 배열을 설정
        }

        if let yourCardsData = UserDefaults.standard.data(forKey: yourCardsKey) {
            do {
                let decodedYourCards = try JSONDecoder().decode([ProfileCardModel].self, from: yourCardsData)
                yourCards = decodedYourCards
            } catch {
                print("Error decoding yourCards: \(error)")
                yourCards = getEmptyCardArray() // 데이터가 없을 경우 빈 배열을 설정
            }
        } else {
            yourCards = getEmptyCardArray() // 데이터가 없을 경우 빈 배열을 설정
        }
    }

    // 데이터가 없을 경우 빈 배열을 반환하는 함수
    private func getEmptyCardArray() -> [ProfileCardModel] {
        return []
    }
}

