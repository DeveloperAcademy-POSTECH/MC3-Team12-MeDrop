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
        static let text1 = Color("Text1")
        static let text2 = Color("Text2")
        static let text3 = Color("Text3")
        static let text4 = Color("Text4")
        static let text5 = Color("Text5")
        static let text6 = Color("Text6")
        static let text7 = Color("Text7")
        static let text8 = Color("Text8")
    }
    
    public enum ButtonColor {
        static let button1 = Color("Button1")
        static let button2 = Color("Button2")
        static let button3 = Color("Button3")
        static let button4 = Color("Button4")
        static let button5 = Color("Button5")
        static let button6 = Color("Button6")
        static let button7 = Color("Button7")
        static let toggle1 = Color("Toggle1")
        static let toggle2 = Color("Toggle2")
    }
    
    public enum BackgroundColor {
        static let background1 = Color("Background1")
        static let background2 = Color("Background2")
        static let onboardingDefault = Color("OnboardingDefault")
        static let OnboardingOn = Color("OnboardingON")
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
}
