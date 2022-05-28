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
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}
