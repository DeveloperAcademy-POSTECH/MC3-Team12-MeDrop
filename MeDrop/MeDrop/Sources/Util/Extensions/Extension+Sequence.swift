//
//  Extension+Sequence.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/08/02.
//

import Foundation
import MultipeerConnectivity
extension Sequence where Element == MCPeerID {
    
    func uniqued() -> [Element] {
        var displayNames = [String:Bool]()
        
        return filter { element in
            if displayNames[element.displayName] == nil {
                displayNames[element.displayName] = true
                return true
            }
            else {
                return false
            }
            return true
        }
    }
}
