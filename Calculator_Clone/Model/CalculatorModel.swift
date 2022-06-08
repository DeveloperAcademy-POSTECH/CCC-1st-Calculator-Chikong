//
//  CalculatorModel.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/06/01.
//

import SwiftUI

class CalculatorModel: ObservableObject {
    
    @Published var valueText: String = "0"
    @Published var isNegative = false
    @Published var isDot = false
    @Published var errorCheck = false
    @Published var isDrag = false
    @Published var isEqual = false
    
    var numStack = [Double]()
    var opStack = ""
    var number: Double = 0
    var oper: String = ""
    var dotCheckNumber: Double = 10
    var opCheck = false
    var currentOp = ""
    
    private var numberFormatter = NumberFormatter()
    
    /// AC 버튼 클릭
    func setClear() {
        numStack = [Double]()
        number = 0
        oper = ""
        opStack = ""
        valueText = "0"
        dotCheckNumber = 10
        isNegative = false
        isDot = false
        opCheck = false
        currentOp = ""
        errorCheck = false
        isEqual = false
    }
    
    // number 와 op 스택 추가 및 초기화 함수
    func addStack() {
        guard !self.oper.isEmpty else { return }
        
        opStack += self.oper
        opCheck = false
        
        dotCheckNumber = 10
        self.number = 0
        self.currentOp = self.oper
        self.oper = ""
    }
    
    /// dot 활성화 상태로 숫자 클릭시 처리하는 함수
    func clickedNumberButtonActiveDot(_ number: CalculatorButton) {
        addStack()
        
        switch isNegative {
        case true:
            guard valueText.count < 11 else { return }
            self.number -= Double(number.rawValue)! / dotCheckNumber
        case false:
            guard valueText.count < 10 else { return }
            self.number += Double(number.rawValue)! / dotCheckNumber
        }
        
        dotCheckNumber *= 10
        preCalcu()
        updateText(self.number)
    }
    
    /// number 0 ~ 9 클릭시 처리하는 함수
    func clickedNumberButton(_ number: CalculatorButton) {
        addStack()
        
        switch isNegative {
        case true:
            guard String(self.number).count < 12 else { return }
            self.number = (self.number * 10) - (Double(number.rawValue)!)
        case false:
            guard String(self.number).count < 11 else { return }
            self.number = (self.number * 10) + (Double(number.rawValue)!)
        }
        
        preCalcu()
        updateText(self.number)
    }
    
    /// 곱셈 및 나눗셈 우선 처리
    func preCalcu() {
        guard opStack.last == "*" || opStack == "/" else { return }
        
        self.currentOp = String(opStack.removeLast())
        
        switch self.currentOp {
        case "*":
            numStack.append(numStack.removeLast() * self.number)
        default:
            if self.number == 0 { self.errorCheck = true; return }
            numStack.append(numStack.removeLast() / self.number)
        }
    }
    
    /// 연산자 [ +, -, x, / ] 버튼 클릭 처리 함수
    func clickedOperatorButton(_ op: CalculatorButton) {
        guard !errorCheck else { return }
        
        self.oper = op.rawValue
        
        guard !opCheck else { return }
        
        numStack.append(self.number)
        
        opCheck = true
        isDot = false
        isNegative = false
    }
    
    /// '=' 버튼 클릭 처리 함수
    func clickedEqualButton() {
        guard !numStack.isEmpty else { return }
        
        if currentOp == "+" || currentOp == "-" {
            numStack.append(self.number)
        }
        
        if !self.oper.isEmpty { opStack += self.oper }
        else { opStack += self.currentOp }
        
        while opStack.count != 1 {
            switch opStack.removeFirst() {
            case "*":
                numStack.append(numStack.removeFirst() * numStack.removeFirst())
            case "/":
                numStack.append(numStack.removeFirst() / numStack.removeFirst())
            case "+":
                numStack.append(numStack.removeFirst() + numStack.removeFirst())
            default:
                numStack.append(numStack.removeFirst() - numStack.removeFirst())
            }
        }
        
        if currentOp == "*" || currentOp == "/" {
            numStack.append(self.number)
        }
        self.isEqual = true
        updateText(numStack.first!)
    }
    
    /// . 클릭 처리 함수
    func clickedDotButton() {
        guard !errorCheck else { return }
        guard !valueText.contains(".") else { return }
        valueText += "."
        
        isDot = true
    }
    
    /// % 버튼 클릭 처리 함수
    func clickedPercentButton() {
        guard !errorCheck else { return }
        number /= 100
        updateText(self.number)
    }
    
    /// 부호 반전 버튼 클릭 처리 함수
    func clickedNegativeButton() {
        guard !errorCheck else { return }
        self.number *= -1
        self.isNegative.toggle()
        
        updateText(self.number)
    }
    
    /// Clear 상태 체크 함수
    func checkClear() -> Bool {
        return self.number == 0 && valueText == "0"
    }
    
    /// Text 업데이트 함수
    func updateText(_ updateNumber: Double) {
        numberFormatter.roundingMode = .floor
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumSignificantDigits = 0
        numberFormatter.maximumSignificantDigits = 9
        
        let result = numberFormatter.string(from: NSNumber(value: updateNumber))!
        
        let resultLength = result.filter { item in
            return item != ","
        }
        
        switch resultLength.count {
        case 0...10:
            valueText = result
        default:
            valueText = String(format: "%g", self.number)
        }
    }
    
    func dragNumberEditing() {
        guard !self.isDrag && !self.isEqual else { return }
    
        var removeFomatterNum = valueText.filter { item in
            return item != ","
        }
        
        switch removeFomatterNum.removeLast() {
        case ".":
            isDot = false
        default:
            self.number = Double(removeFomatterNum) ?? 0
        }
        
        updateText(self.number)
    }
}
