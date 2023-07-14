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

//class MyCardTestViewModel: ObservableObject {
//    @Published var cards: [ProfileCardModel] = []
//
//    func loadUserData() {
//        //        guard let currentUserID = Auth.auth().currentUser?.uid else {
//        //            // 현재 사용자 ID를 가져오는 데 실패하였습니다.
//        //            return
//        //        }
//
//        let usersRef = FireBaseDataBaseManager.shared.child("users")
//
//        // 현재 사용자의 문서에 액세스하여 myCards 필드를 가져옵니다.
//        usersRef.child("BentleyID").observeSingleEvent(of: .value) { (snapshot) in
//            if let userData = snapshot.value as? [String: Any], let myCards = userData["myCards"] as? [String] {
//                // myCards 배열이 존재하면 각 카드에 대한 정보를 가져옵니다.
//                for cardID in myCards {
//                    if let cardData = self.getCardData(cardID: cardID) {
//                        // 카드 데이터를 파싱하여 ProfileCardModel로 변환합니다.
//                        if let cardModel = self.parseCardData(cardData) {
//                            // cards 배열에 카드를 추가합니다.
//                            DispatchQueue.main.async {
//                                self.cards.append(cardModel)
//                            }
//                        } else {
//                            // 카드 데이터가 올바르게 파싱되지 않았습니다.
//                            print("Invalid card data format.")
//                        }
//                    } else {
//                        // 카드 데이터가 없거나 데이터가 올바르게 파싱되지 않았습니다.
//                        print("No card data found or invalid data format.")
//                    }
//                }
//            } else {
//                // myCards 배열이 없거나 데이터가 올바르게 파싱되지 않았습니다.
//                print("No myCards data found or invalid data format.")
//            }
//        }
//    }
//
//    private func getCardData(cardID: String) -> [String: Any]? {
//        let cardsRef = FireBaseDataBaseManager.shared.child("cards")
//
//        if let cardData = cardsRef.child(cardID).value as? [String: Any] {
//            return cardData
//        }
//
//        return nil
//    }
//
//    private func parseCardData(_ data: [String: Any]) -> ProfileCardModel? {
//        // 카드 데이터를 파싱하여 ProfileCardModel로 변환합니다.
//        // 필요한 필드들을 추출하고, 적절한 초기화를 수행합니다.
//
//        guard let cardDataString = data["cardData"] as? String else {
//            return nil
//        }
//
//        guard let cardData = try? JSONSerialization.jsonObject(with: Data(cardDataString.utf8), options: []) as? [String: Any] else {
//            return nil
//        }
//
//        guard
//            let introduction = cardData["introduction"] as? String,
//            let id = cardData["id"] as? String,
//            let contact = cardData["contact"] as? String,
//            let company = cardData["company"] as? String,
//            let colorSetString = cardData["colorSet"] as? String,
//            let colorSet = ColorSet(rawValue: colorSetString),
//            let email = cardData["email"] as? String,
//            let link = cardData["link"] as? String,
//            let job = cardData["job"] as? String,
//            let name = cardData["name"] as? String
//        else {
//            return nil
//        }
//
//        return ProfileCardModel(
//            id: id,
//            name: name,
//            contact: contact,
//            company: company,
//            job: job,
//            introduction: introduction,
//            colorSet: colorSet,
//            email: email,
//            link: link
//        )
//    }
//}
