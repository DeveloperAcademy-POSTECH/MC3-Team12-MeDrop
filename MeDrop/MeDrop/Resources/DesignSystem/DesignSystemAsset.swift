//
//  DesignSystemAsset.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/07.
//

import Foundation
import SwiftUI

public enum DesignSystemAsset {
    public enum CardColor {
        static let black = Color("Black")
        static let blue1 = Color("Blue1")
        static let neonPink = Color("NeonPink")
        static let lime = Color("Lime")
        static let white = Color("White")
    }
    public enum TextColor {
        static let black = Color("Black")
        static let gray1 = Color("Gray1")
        static let gray2 = Color("Gray2")
        static let red = Color("Red")
    }
    
    public enum ButtonColor {
        static let black = Color("Black")
        static let white2 = Color("White2")
        static let neonPink = Color("NeonPink")
        static let lime = Color("Lime")
        static let gray3 = Color("Gray3")
    }
    
    public enum IconColor {
        static let gray4 = Color("Gray4")
        static let blue1 = Color("Blue1")
        static let white = Color("White")
        static let gray5 = Color("Gray5")
    }
    
    public enum CardText {
        static let black = Color("Black")
        static let white = Color("White")
    }
    
    public enum ButtonTextColor {
        static let white = Color("White")
        static let gray2 = Color("Gray2")
        static let blue1 = Color("Blue1")
    }
    
    public enum OnBoardImage {
        static let onboard1 = "onBoardImg1"
        static let onboard2 = "onBoardImg2"
        static let onboard3 = "onBoardImg3"
    }
    
    enum OnBoardText: String {
        case obt1 = "**간편하게** 제작하는\n나만의 명함, **Me-card.**"
        case obt2 = "나를 **각인**시키는\n명함교환, **Me-Sync.**"
        case obt3 = "빠르게 **연결**되는\n비지니스, **Me-Drop.**"
        case obt4 = "번거로운 **명함**관리이제는 **간편하게** 해요."
    }
}
