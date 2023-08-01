//
//  Profile+ProfileInfoModel.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import SwiftUI

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
    
    var designType: String { get set }
    
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
    
    var designType: String = ""
    
    var date: Int = 20200101

    func complete() -> Bool {
        if name.isEmpty == false && job.isEmpty == false && contact.isEmpty == false && company.isEmpty == false && contact.count == 13 {
            return true
        } else {
            return false
        }
    }
    
    func back() -> Bool {
        if name.isEmpty && contact.isEmpty && company.isEmpty || !job.isEmpty || !introduction.isEmpty {
            return true
        } else {
            return false
        }
    }
}

extension ProfileCardModel {
    static var sampleData: [ProfileCardModel] = [
        ProfileCardModel(name: "젤리빈", contact: "010-0000-0000", company: "􀣺 jelly Developer Academy", job: "Designer.", introduction: "한 줄 소개; 젤리빈 어쩌구 저쩌구", email: "jellyBeen@gmail.com", link: "jellyBeen.com", designType: "0-0", date: 20200102),
        ProfileCardModel(name: "릴리", contact: "010-1111-1111", company: "􀣺 lily Academy", job: "Developer.", introduction: "한 줄 소개; 릴리 개발자", email: "lily@gmail.com", link: "lily.com", insta: "@seooo_02", designType: "0-1", date: 20200103),
        ProfileCardModel(name: "호제", contact: "010-2222-2222", company: "􀣺 hoje Developer ", job: "CEO.", introduction: "한 줄 소개; 호제 CEO", email: "hoje@gmail.com", link: "hoje.com", designType: "1-0", date: 20200104),
        ProfileCardModel(name: "제이", contact: "010-3333-3333", company: "􀣺 jay Developer ", job: "CTO.", introduction: "한 줄 소개; 제이 CEO", email: "jay@gmail.com", link: "jay.com", designType: "1-3", date: 20200109),
        ProfileCardModel(name: "카일", contact: "010-4444-4444", company: "􀣺 kayle Developer ", job: "COO.", introduction: "한 줄 소개; 카일 CEO", email: "kayle@gmail.com", link: "kayle.com", designType: "2-4", date: 20200110)
    ]
}

extension ProfileCardModel {
    static var emptyCard: ProfileCardModel {
        ProfileCardModel(name: "", contact: "", company: "", job: "", introduction: "", email: "", link: "", date: 20220808)
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
            links.append(SocialMediaLink(name: "Instagram", icon: "Instagram", link: insta))
        }
        return links
    }
    
    
    // 여기
    func link(for socialMedia: SocialMediaLink) -> String {
        if socialMedia.name == "Instagram" {
            return "https://www.instagram.com/" + insta
        } else if socialMedia.name == "Youtube" {
            return "https://www.youtube.com/" + youtube
        } else {
            return socialMedia.link
        }
    }
}
