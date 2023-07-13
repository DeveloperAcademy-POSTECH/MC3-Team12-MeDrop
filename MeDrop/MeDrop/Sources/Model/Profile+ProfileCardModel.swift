//
//  Profile+ProfileInfoModel.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import Foundation
import SwiftUI
//
//  Profile+ProfileInfoModel.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import Foundation
import SwiftUI

class EnvironmentData: ObservableObject {
    @Published var cardNum: [Int] = []
}

protocol ProfileCard: Identifiable, Codable {
    var name: String { get set }
    var contact: String { get set }
    var company: String { get set }
    var job: String { get set }
    var introduction: String { get set }
    
    var email: String { get set }
    var link: String { get set }
    
    var colorSet: ColorSet { get set }
    
    func complete() -> Bool
    func back() -> Bool
}

struct ProfileCardModel: ProfileCard {
    var id = UUID()
    
    var name: String = ""
    var contact: String = ""
    var company: String = ""
    var job: String = ""
    var introduction: String = ""

    var colorSet: ColorSet = .white

    var email: String = ""
    var link: String = ""
    
    func complete() -> Bool {
        if name.isEmpty || contact.isEmpty || company.isEmpty || job.isEmpty || introduction.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func back() -> Bool {
        if !name.isEmpty || !contact.isEmpty || !company.isEmpty || !job.isEmpty || !introduction.isEmpty {
            return true
        } else {
            return false
        }
    }
}

extension ProfileCardModel {
    static let sampleData: [ProfileCardModel] = [
        ProfileCardModel(name: "젤리빈", contact: "010-0000-0000", company: "􀣺 jelly Developer Academy", job: "Designer.", introduction: "한 줄 소개; 젤리빈 어쩌구 저쩌구", colorSet: .white, email: "jellyBeen@gmail.com", link: "jellyBeen.com"),
        ProfileCardModel(name: "릴리", contact: "010-1111-1111", company: "􀣺 lily Academy", job: "Developer.", introduction: "한 줄 소개; 릴리 개발자", colorSet: .neonPink, email: "lily@gmail.com", link: "lily.com"),
        ProfileCardModel(name: "호제", contact: "010-2222-2222", company: "􀣺 hoje Developer ", job: "CEO.", introduction: "한 줄 소개; 호제 CEO", colorSet: .lime, email: "hoje@gmail.com", link: "hoje.com"),
        ProfileCardModel(name: "제이", contact: "010-3333-3333", company: "􀣺 jay Developer ", job: "CTO.", introduction: "한 줄 소개; 제이 CEO", colorSet: .black, email: "jay@gmail.com", link: "jay.com"),
        ProfileCardModel(name: "카일", contact: "010-4444-4444", company: "􀣺 kayle Developer ", job: "COO.", introduction: "한 줄 소개; 카일 CEO", colorSet: .blue1, email: "kayle@gmail.com", link: "kayle.com")
    ]
}
