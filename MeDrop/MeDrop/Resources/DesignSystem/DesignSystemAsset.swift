//
//  DesignSystemAsset.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//

import Foundation
import SwiftUI

public enum DesignSystemAsset {
    
    static let mainBlue = Color("MainBlue")
    static let blue2 = Color("Blue2")
    static let blue3 = Color("Blue3")
    static let blue4 = Color("Blue4")
    static let btBlue = Color("BTBlue")
    
    static let btBeige = Color("BTBeige")
    
    static let mainRed = Color("MainRed")
    
    static let mainYellow = Color("MainYellow")
    static let yellow2 = Color("Yellow2")
    
    static let gray1 = Color("Gray1")
    static let gray2 = Color("Gray2")
    static let gray3 = Color("Gray3")
    static let gray4 = Color("Gray4")
    
    static let white1 = Color("White")
    static let white2 = Color("White2")
    
    static let black = Color("Black")
    
    public enum OnBoardImage {
        static let onboard1 = "onBoardImg1"
        static let onboard2 = "onBoardImg2"
        static let onboard3 = "onBoardImg3"
        static let onboard4 = "obBoardImg4"
    }
    
    enum OnBoardText: String {
        case obt1 = "**간편하게** 제작하는\n나만의 명함, **Me-card.**"
        case obt2 = "나를 **각인**시키는\n명함교환, **Me-Sync.**"
        case obt3 = "빠르게 **연결**되는\n비지니스, **Me-Drop.**"
        case obt4 = "번거로운 **명함**관리이제는 **간편하게** 해요."
    }
    
    enum Jelly: String {
        case yellowSmallJelly = "yellowSmallJelly"
        case requestJelly = "RequestJelly"
    }
}
