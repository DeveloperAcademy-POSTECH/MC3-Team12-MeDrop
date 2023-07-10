//
//  Profile+ProfileInfoModel.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import Foundation
import SwiftUI

protocol ProfileCard: Identifiable {
    var lastName: String { get set }
    var firstName: String { get set }
    var contact: String { get set }
    var email: String { get set }
    var company: String { get set }
    var job: String { get set }
    var introduction: String { get set }
    
    func complete() -> Bool
    func back() -> Bool
    var card: Color { get set }
}

enum Card: String {
    case black
    case pink
    case lime
    case white
}

struct ProfileCardModel: ProfileCard {
    var id = UUID()
    
    var lastName: String = ""
    var firstName: String = ""
    var contact: String = ""
    var email: String = ""
    var company: String = ""
    var job: String = ""
    var introduction: String = ""
    var card: Color = Color.white
    
    func complete() -> Bool {
        if lastName.isEmpty || firstName.isEmpty || contact.isEmpty || company.isEmpty || job.isEmpty || introduction.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func back() -> Bool {
        if !lastName.isEmpty || !firstName.isEmpty || !contact.isEmpty || !company.isEmpty || !job.isEmpty || !introduction.isEmpty {
            return true
        } else {
            return false
        }
    }
}
