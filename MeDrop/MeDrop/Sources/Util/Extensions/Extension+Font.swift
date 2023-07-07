//
//  Extension+Font.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//

import Foundation
import SwiftUI


extension Font {
    
    static func regular(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Regular", size: size) }
    static func ultralight(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Ultralight", size: size) }
    static func thin(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Thin", size: size) }
    static func light(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Light", size: size) }
    static func medium(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Medium", size: size) }
    static func semiBold(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Semibold", size: size) }
    static func black(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Black", size: size) }
    static func heavy(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Heavy", size: size) }
    static func bold(_ size: CGFloat = 10) -> Font { return Font.custom("SFProText-Bold", size: size) }
    
}
