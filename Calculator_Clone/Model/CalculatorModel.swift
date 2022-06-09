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
    @Published var oper: String = ""
    
    var fomulaStack = [Any]()
    
    var numStack = [Double]()
    var number: Double = 0
    var opStack = ""
    var dotCheckNumber: Double = 10
    var opCheck = false
    var currentOp = ""
    
    private var numberFormatter = NumberFormatter()
    
    func calcuPostfix(_ fomula: [Any]) {

        var answer = [Double]()
        
        for op in fomula {
            switch op as? Character {
            case "*":
                answer.append(answer.removeLast() * answer.removeLast())
            case "/":
                let stackLast = answer.removeLast()
                answer.append(answer.removeLast() / stackLast)
            case "+":
                answer.append(answer.removeLast() + answer.removeLast())
            case "-":
                let stackLast = answer.removeLast()
                answer.append(answer.removeLast() - stackLast)
            default:
                answer.append(op as! Double)
            }
        }
        numStack.append(answer.first!)
        updateText(answer.first!)
    }
    
    func setPostfix() {
        currentOp = String(opStack.last ?? "+")
        
        fomulaStack = []
        
        while !numStack.isEmpty {
            fomulaStack.append(numStack.removeFirst())
            if !opStack.isEmpty {
                fomulaStack.append(opStack.removeFirst())
            }
        }
        var tempStack = [Any]()
        var postfix = [Any]()
        
        for op in fomulaStack {
            switch op as? Character {
            case "*", "/":
                while !tempStack.isEmpty && (tempStack.last as? String == "*" || tempStack.last as? String == "/") {
                    postfix.append(tempStack.removeLast())
                }
                tempStack.append(op)
            case "+", "-":
                while !tempStack.isEmpty{
                    postfix.append(tempStack.removeLast())
                }
                tempStack.append(op)
            default:
                postfix.append(op)
            }
        }
        
        while !tempStack.isEmpty {
            postfix.append(tempStack.removeLast())
        }
        
        calcuPostfix(postfix)
    }
    
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
        errorCheck = false
        isEqual = false
        fomulaStack = [Any]()
        currentOp = ""
    }
    
    // number 와 op 스택 추가 및 초기화 함수
    func addStack() {
        guard !self.oper.isEmpty else { return }
        
        opStack += self.oper
        opCheck = false
        
        dotCheckNumber = 10
        self.number = 0
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
        
        updateText(self.number)
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
        if !self.oper.isEmpty { opStack += self.oper }
        numStack.append(self.number)
        
        setPostfix()
        opStack += currentOp
        self.isEqual = true
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
