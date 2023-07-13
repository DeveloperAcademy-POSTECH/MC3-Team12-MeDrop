//
//  ProfileFBTest.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/12.
//


import Firebase

func loadUserData () -> Void {
    var ref: DatabaseReference! = FireBaseDataBaseManager.shared
    
    let DBref = ref.child("cards").child("dummyCard")
    
    DBref.observeSingleEvent(of: .value) { snapshot in
        if let cardData = snapshot.value as? [String] {
            let name = cardData[0] // "Jose"
            let phoneNumber = cardData[1] // "010-0000-0000"
            let company = cardData[2] // "ADA"
            let job = cardData[3] // "Developer"
            let introduction = cardData[4] // "안녕! 난 호제!"
            let color = cardData[5] // "black"
            let email = cardData[6] // "email@emal.com"
            let link = cardData[7] // "apple.com"
            
            // 가져온 데이터 처리
            print("Name: \(name), Phone Number: \(phoneNumber), Company: \(company), Job: \(job), Introduction: \(introduction), Color: \(color), Email: \(email), Link: \(link)")
        }
    }
}
