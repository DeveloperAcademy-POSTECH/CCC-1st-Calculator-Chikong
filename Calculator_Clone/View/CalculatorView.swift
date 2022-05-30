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
                    }, label: {
                        buttonText(buttonItem)
                    })
                    .buttonStyle(CustomButton(buttonItem: buttonItem))
                }
            }
        }
    }
    
    // 버튼의 텍스트를 설정하는 함수 ( SF 심볼의 경우와 일반 Text인 경우 )
    func buttonText(_ item: CalculatorButton) -> Text {
        switch item {
        case .negative:
            return Text(Image(systemName: "plus.forwardslash.minus"))
        case .plus:
            return Text(Image(systemName: "plus"))
        case .minus:
            return Text(Image(systemName: "minus"))
        case .multiple:
            return Text(Image(systemName: "multiply"))
        case .divide:
            return Text(Image(systemName: "divide"))
        case .equal:
            return Text(Image(systemName: "equal"))
        case .modular:
            return Text(Image(systemName: "percent"))
        default:
            return Text("\(item.rawValue)")
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
