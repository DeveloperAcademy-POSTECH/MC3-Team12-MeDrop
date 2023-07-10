//
//  Profile+ProfileInfoModel.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import Foundation



protocol ProfileCard {
    
    
}

extension ProfileCard {
    enum Info: String {
        case name
        case contact
        case company
        case job
        case introduction
        case email
    }
    enum Card: String {
        case black
        case pink
        case lime
        case white
    }
}

struct ProfileInfoModel {
    
    var profileCard =
    
    mutating func setup(name: String, contact: String, company: String, job: String, email: String, introduction: String){
        self.name = name
        self.contact = contact
        self.company = company
        self.job = job
        self.email = email
        self.introduction = introduction
    }
}
