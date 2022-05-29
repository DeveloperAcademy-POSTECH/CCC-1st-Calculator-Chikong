//
//  CalculatorView.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/05/29.
//

import SwiftUI

struct CalculatorView: View {
    
    let calcuButton: [[CalculatorButton]] = [
        [.clear, .negative, .modular, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        ForEach(calcuButton, id:\.self) { row in
            HStack(spacing: 12) {
                ForEach(row, id:\.self) { buttonItem in
                    Button(action: {
                        // 기능 구현
                    }) {
                        CalcuButtonView(buttonItem: buttonItem)
                    }
                }
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
