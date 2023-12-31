//
//  ColorSetModel.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/10.
//

import SwiftUI

enum ColorSet: String, CaseIterable, Identifiable, Codable {
    case black
    case blue1
    case neonPink
    case white
    case lime
    
    var cardColor: Color {
        switch self {
        case .black: return DesignSystemAsset.CardColor.black
        case .blue1: return DesignSystemAsset.CardColor.blue1
        case .neonPink: return DesignSystemAsset.CardColor.neonPink
        case .white: return DesignSystemAsset.CardColor.white
        case .lime: return DesignSystemAsset.CardColor.lime
        }
    }
    
    var cardTextColor: Color {
        switch self {
        case .black, .blue1: return DesignSystemAsset.CardText.white
        case .lime, .neonPink, .white: return DesignSystemAsset.CardText.black
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .black, .blue1: return DesignSystemAsset.ButtonColor.button4 // 변경
        case .neonPink: return DesignSystemAsset.ButtonColor.button4 // 변경
        case .white: return DesignSystemAsset.ButtonColor.button4 // 변경
        case .lime: return DesignSystemAsset.ButtonColor.button4 // 변경
        }
    }
    
    var buttonTextColor: Color {
        switch self {
        case .neonPink, .white: return DesignSystemAsset.ButtonTextColor.white
        case .blue1: return DesignSystemAsset.ButtonTextColor.blue1
        case .black, .lime: return DesignSystemAsset.ButtonTextColor.black
        }
    }
    
    var contentBackgroundColor: Color {
        switch self {
        case .black: return DesignSystemAsset.CardColor.black
        case .blue1: return DesignSystemAsset.CardColor.blue1
        case .neonPink: return DesignSystemAsset.CardColor.white
        case .white: return DesignSystemAsset.CardColor.white
        case .lime: return DesignSystemAsset.CardColor.white
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .black: return DesignSystemAsset.CardColor.white
        case .blue1: return DesignSystemAsset.CardColor.white
        case .neonPink: return DesignSystemAsset.CardColor.neonPink
        case .white: return DesignSystemAsset.CardColor.black
        case .lime: return DesignSystemAsset.CardColor.lime
        }
    }

    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
