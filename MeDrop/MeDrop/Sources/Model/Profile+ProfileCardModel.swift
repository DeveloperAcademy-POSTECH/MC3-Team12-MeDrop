//
//  Profile+ProfileInfoModel.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

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
    
    var insta: String { get set }
    var twitter: String { get set }
    var github: String { get set }
    var linkedin: String { get set }
    var youtube: String { get set }
    
    var type: Int { get set }
    var animated: Bool { get set }
    var color: [CGFloat] { get set }
    
    var date: Int { get set }
    
    func complete() -> Bool
    func back() -> Bool
}

struct ProfileCardModel: ProfileCard, Identifiable,Hashable {
    var id = UUID()
    
    var name: String = ""
    var contact: String = ""
    var company: String = ""
    var job: String = ""
    var introduction: String = ""

    var email: String = ""
    var link: String = ""
    
    var insta: String = ""
    var twitter: String = ""
    var github: String = ""
    var linkedin: String = ""
    var youtube: String = ""
    
    var type: Int = 0
    var animated: Bool = true
    var color: [CGFloat] = [0.4, 0.5, 0.2]
    
    var date: Int = 20200101


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
    static var sampleData: [ProfileCardModel] = [
        ProfileCardModel(name: "젤리빈", contact: "010-0000-0000", company: "􀣺 jelly Developer Academy", job: "Designer.", introduction: "한 줄 소개; 젤리빈 어쩌구 저쩌구", email: "jellyBeen@gmail.com", link: "jellyBeen.com", color: [0.4, 0.5, 0.2], date: 20200102),
        ProfileCardModel(name: "릴리", contact: "010-1111-1111", company: "􀣺 lily Academy", job: "Developer.", introduction: "한 줄 소개; 릴리 개발자", email: "lily@gmail.com", link: "lily.com", insta: "@seooo_02", color: [0.4, 0.5, 0.2], date: 20200103),
        ProfileCardModel(name: "호제", contact: "010-2222-2222", company: "􀣺 hoje Developer ", job: "CEO.", introduction: "한 줄 소개; 호제 CEO", email: "hoje@gmail.com", link: "hoje.com", color: [0.4, 0.5, 0.2], date: 20200104),
        ProfileCardModel(name: "제이", contact: "010-3333-3333", company: "􀣺 jay Developer ", job: "CTO.", introduction: "한 줄 소개; 제이 CEO", email: "jay@gmail.com", link: "jay.com", color: [0.4, 0.5, 0.2], date: 20200109),
        ProfileCardModel(name: "카일", contact: "010-4444-4444", company: "􀣺 kayle Developer ", job: "COO.", introduction: "한 줄 소개; 카일 CEO", email: "kayle@gmail.com", link: "kayle.com", color: [0.4, 0.5, 0.2], date: 20200110)
    ]
}


extension ProfileCardModel {
    static var emptyCard: ProfileCardModel {
        ProfileCardModel(name: "", contact: "", company: "", job: "", introduction: "", email: "", link: "", color: [0.4, 0.5, 0.2])
    }
}

extension ProfileCardModel {
    struct SocialMediaLink: Hashable {
        let name: String
        let icon: String
        let link: String
    }
    
    var socialMediaLinks: [SocialMediaLink] {
        var links: [SocialMediaLink] = []
        if !link.isEmpty {
            links.append(SocialMediaLink(name: "link", icon: "link", link: link))
        }
        if !github.isEmpty {
            links.append(SocialMediaLink(name: "GitHub", icon: "github", link: github))
        }
        if !youtube.isEmpty {
            links.append(SocialMediaLink(name: "YouTube", icon: "youtube", link: youtube))
        }
        if !linkedin.isEmpty {
            links.append(SocialMediaLink(name: "LinkedIn", icon: "linkedin", link: linkedin))
        }
        if !twitter.isEmpty {
            links.append(SocialMediaLink(name: "Twitter", icon: "twitter", link: twitter))
        }
        if !insta.isEmpty {
            links.append(SocialMediaLink(name: "Instagram", icon: "instagram", link: insta))
        }
        return links
    }
    
    func link(for socialMedia: SocialMediaLink) -> String {
            return socialMedia.link
        }
}
