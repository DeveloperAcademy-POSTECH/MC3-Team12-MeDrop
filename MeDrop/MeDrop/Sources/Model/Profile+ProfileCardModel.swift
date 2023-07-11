//
//  Profile+ProfileInfoModel.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import Foundation
import SwiftUI

protocol ProfileCard: Identifiable {
    var name: String { get set }
    var contact: String { get set }
    var email: String { get set }
    var company: String { get set }
    var job: String { get set }
    var introduction: String { get set }
    var colorSet: ColorSet { get set }
    
    func complete() -> Bool
    func back() -> Bool
}

struct ProfileCardModel: ProfileCard {
    var id: UUID = UUID()
    var name: String = ""
    var contact: String = ""
    var email: String = ""
    var company: String = ""
    var job: String = ""
    var introduction: String = ""
    var colorSet: ColorSet = .white
    
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
        ProfileCardModel(name: "이우빈", contact: "010-0000-0000", email: "kdbvkdbsvbn@gmail.com", company: "􀣺 Apple Developer Academy", job: "Designer.", introduction: "한 줄 소개; 안녕하세요 어쩌구 저쩌구", colorSet: .white),
        ProfileCardModel(name: "릴리", contact: "010-0000-0000", email: "kdbvkdbsvbn@gmail.com", company: "􀣺 Apple Academy", job: "Developer.", introduction: "한 줄 소개; 릴리 개발자", colorSet: .neonPink),
        ProfileCardModel(name: "호제", contact: "010-0000-0000", email: "kdbvkdbsvbn@gmail.com", company: "􀣺 Apple Developer ", job: "CEO.", introduction: "한 줄 소개; 호제 CEO", colorSet: .lime),
        ProfileCardModel(name: "호제", contact: "010-0000-0000", email: "kdbvkdbsvbn@gmail.com", company: "􀣺 Apple Developer ", job: "CEO.", introduction: "한 줄 소개; 호제 CEO", colorSet: .black),
        ProfileCardModel(name: "호제", contact: "010-0000-0000", email: "kdbvkdbsvbn@gmail.com", company: "􀣺 Apple Developer ", job: "CEO.", introduction: "한 줄 소개; 호제 CEO", colorSet: .blue1)
    ]
}
