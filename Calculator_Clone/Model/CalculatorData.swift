//
//  CalculatorData.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/05/30.
//

import SwiftUI

class CalculatorData: ObservableObject {
    @Published var valueText = "0"
    @Published var numberConv = ""
    @Published var formula = ""
    @Published var op = ""
        
    private let numberFormatter = NumberFormatter()
    
    // +/-
    func negativeSet() {
        if numberConv.isEmpty { numberConv = "0"}
        
        if (numberConv.first == "-") {
            numberConv.removeFirst()
        } else {
            numberConv = "-" + numberConv
        }
        numberFormat(numberConv)
    }
    
    // .modular
    func modular() {
        guard !numberConv.isEmpty else { return }
        numberConv = String(Double(numberConv)!/100)
        numberFormat(numberConv)
    }
    
    // .equal
    func calcuResult() {
        formula += numberConv
        
        let expression = NSExpression(format:formula)
        let value = expression.expressionValue(with: nil, context: nil) as? Double
        
        numberFormat(String(value!))
    }
    
    // .dot
    func dotSet() {
        guard !numberConv.contains(".") else { return }
        numberConv = numberConv.isEmpty ? "0." : numberConv + "."
        numberFormat(numberConv)
        print(numberConv)
    }
    
    // .plus, .minus, .multiple, .divide
    func operatorSet(_ item: CalculatorButton) {
        switch item {
        case .plus:
            op = "+"
        case .minus:
            op = "-"
        case .multiple:
            op = "*"
        case .divide:
            op = "/"
        default:
            return
        }
        
        if !numberConv.isEmpty {
            formula = formula + numberConv + op
        }
        numberConv = ""
    }
    
    // 3자리 마다 숫자를 찍기 위한 함수
    func numberFormat(_ number: String) {
        numberFormatter.numberStyle = .decimal
        
        if number.last == "." {
            valueText = numberFormatter.string(from: NSNumber(value:Double(number[..<number.endIndex])!))! + "."
        } else {
            valueText = numberFormatter.string(from: NSNumber(value:Double(number)!))!
        }
    }
    
    // AC 버튼
    func formulaInit() {
        valueText = "0"
        numberConv = ""
        formula = ""
        op = ""
    }
    
    // 숫자 버튼 클릭시 적용되는 함수 ( 코드가 너무 가독성이 떨어져서 수정할 필요성을 느낌 )
    func clickedNumber(_ item: CalculatorButton) {
        guard numberConv.count < 9 else { return }
        
        if numberConv.isEmpty {
            if item != .zero {
                numberConv = item.rawValue
            }
        } else {
            if numberConv == "0" {
                if item != .zero {
                    numberConv = ""
                    numberConv += item.rawValue
                }
            } else {
                numberConv += item.rawValue
            }
        }
        if !numberConv.isEmpty {
            numberFormat(numberConv)
        }
    }
    
    // AC 상태인지 아닌지 확인하는 함수
    func clearToCalcu() -> Bool {
        return numberConv.isEmpty && formula.isEmpty
    }
}
