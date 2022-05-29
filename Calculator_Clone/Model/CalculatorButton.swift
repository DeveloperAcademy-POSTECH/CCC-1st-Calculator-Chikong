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
    case plus = "plus"
    case minus = "minus"
    case multiple = "multiple"
    case divide = "divide"
    case clear = "AC"
    case equal = "equal"
    case modular = "modular"
    case negative = "negative"
    
    var buttonColor: Color {
        switch self {
        case .divide, .multiple, .minus, .plus, .equal:
            return .orange
        case .clear, .negative, .modular:
            return Color.calcuButtonColor
        default:
            return Color.numberButtonColor
        }
    }
}

extension Color {
    static let numberButtonColor = Color(hex: "#333333")
    static let calcuButtonColor = Color(hex: "#A5A5A5")
    
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
