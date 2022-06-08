//
//  CalculatorModel.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/05/28.
//

import Foundation
import SwiftUI

enum CalculatorButton: String{
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case dot = "."
    case plus = "+"
    case minus = "-"
    case multiple = "*"
    case divide = "/"
    case clear = "AC"
    case equal = "="
    case percent = "%"
    case negative = "negative"
    
    var buttonColor: Color {
        switch self {
        case .divide, .multiple, .minus, .plus, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color.calcuButtonColor
        default:
            return Color.numberButtonColor
        }
    }
    
    var buttonClickColor: Color {
        switch self {
        case .divide, .equal, .plus, .minus, .multiple:
            return Color.arithmeticClickedButtonColor
        case .negative, .percent, .clear:
            return Color.calcuClickedButtonColor
        default:
            return Color.numberClickedButtonColor
        }
    }
}

extension Color {
    static let numberButtonColor = Color(hex: "#333333")
    static let calcuButtonColor = Color(hex: "#A5A5A5")
    static let calcuClickedButtonColor = Color(hex: "#D9D9D9")
    static let numberClickedButtonColor = Color(hex: "#A6A6A6")
    static let arithmeticClickedButtonColor = Color(hex: "#FBC78D")
    
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
      }
}
