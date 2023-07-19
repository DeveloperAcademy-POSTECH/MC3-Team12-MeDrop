//
//  NearByManager.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/19.
//

import Foundation
import NearbyInteraction
import UIKit

class SwitchData: NSObject, NSCoding {
    let token: NIDiscoveryToken // A unique identifier for a peer device in the session.
    let cardId: String

    init(token: NIDiscoveryToken, cardId: String) {
        self.token = token
        self.cardId = cardId
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.token, forKey: "token")
        coder.encode(self.cardId, forKey: "cardId")
    }
    
    required init?(coder: NSCoder) {
        self.token = coder.decodeObject(forKey: "token") as! NIDiscoveryToken
        self.cardId = coder.decodeObject(forKey: "cardId") as! String
    } 
}
