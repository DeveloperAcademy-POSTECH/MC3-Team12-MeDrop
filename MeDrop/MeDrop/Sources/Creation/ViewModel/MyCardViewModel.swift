////
////  MyCardViewModel.swift
////  MeDrop
////
////  Created by jose Yun on 2023/07/12.
////
//
//import SwiftUI
////import FirebaseAuth
////import FirebaseStorage
//import Firebase
//import SwiftUI
//
//let db = Firestore.firestore().collection("TestCollection")
//
//class CardViewModel: ObservableObject {
//
//    static let shared = CardViewModel()
//
//    // 파이어베이스 서버 측으로부터 현재 로그인 세션 유지 중인 유저 정보가 있는지 확인
//    @Published var userSession: FirebaseAuth.User?
//    @Published var user: User?
//
//    //TODO? 인터넷 연결 없을 시 오류 확인하는 기능 추가해야하나?
//    init() {
//        self.userSession = Auth.auth().currentUser
//        fetchUser { _ in }
//    }
//    
//    func fetchUser(_ completion: @escaping(Bool) -> ()) {
//        guard let uid = userSession?.uid else {
//            completion(false)
//            return
//        }
//
//        // TODO: 세션 내의 유저가 없다면 UserDefaults로 저장된 userId에 대한 밸류값이 있는지 확인하는 부분 추가
//        db.document(uid).getDocument { snapshot , _ in
//            guard let user = try? snapshot?.data(as: User.self) else {
//                self.user?.userId = UserDefaults.shared.string(forKey: "userId") ?? "NaN"
//                return
//            }
//
//            self.user = user
//            UserDefaults.shared.set(user.userId, forKey: "userId")
//            if user.isConnected {
//                UserDefaults.shared.set(user.partnerId, forKey: "partnerId")
//            }
//            print("=== DEBUG: fetch \(self.user)")
//            completion(true)
//        }
//    }
//
//    func uploadImage(image: UIImage, completion: @escaping() -> Void) {
//        guard let uid  = self.user?.userId else { return }
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//
//        let ref = Storage.storage().reference().child("Photos/\(uid)")
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpg"
//
//        ref.putData(imageData, metadata: metadata) { metadata, error in
//            if let error = error {
//                print("=== DEBUG: 이미지 업로드 실패 \(error.localizedDescription)")
//                return
//            }
//
//            ref.downloadURL { url , _ in
//                guard let imageUrl = url?.absoluteString else { return }
//                db.document(uid).updateData(["imageUrl": imageUrl])
//                self.user?.imageUrl = imageUrl
//                completion()
//            }
//        }
//    }
//
//
//func fetchImageUrl(_ completion: @escaping(String) -> Void?) {
//
//     guard let userId = UserDefaults.shared.string(forKey: "userId") else { return }
//
//     db.document(userId).getDocument{ document, error in
//
//         if let _ = error {
//             UserDefaults.shared.set("에러가 발생해 이미지를 불러오지 못했습니다. DEBUG #1", forKey: "notiMessage")
//         } else {
//
//             UserDefaults.shared.set("에러가 발생해 이미지를 불러오지 못했습니다. DEBUG #2", forKey: "notiMessage")
//
//             if let document = document,
//                let data = document.data() {
//                 if let cardInfo = data["imageUrl"] as? String {
//                     UserDefaults.shared.set("요망이 업데이트되었습니다. 확인요망!", forKey: "notiMessage")
//                     UserDefaults.shared.set(partnerImageUrl, forKey: "imageUrl")
//                     print("DEBUG: image url \(partnerImageUrl)")
//
////                     /// NSData로 변환해 저장
////                     guard let url = URL(string: partnerImageUrl) else { return }
////                     URLSession.shared.dataTask(with: url) { data, response, error in
////                         guard let data = data, error == nil else { return }
////                         self.setImageInUserDefaults(UIImage: UIImage(data: data) ?? UIImage(), "widgetImage")
////                     }.resume()
//
//                     completion(partnerImageUrl)
//                 }
//             }
//         }
//     }
// }
//}
