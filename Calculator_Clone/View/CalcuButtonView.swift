//
//  CalcuButtonView.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/05/29.
//

import SwiftUI

struct CalcuButtonView: View {
    
    let buttonItem: CalculatorButton
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .frame(width:calcuWidth(buttonItem), height: calcuHeight())
            .foregroundColor(buttonItem.buttonColor)
            .overlay(){
                HStack{
                    buttonText(buttonItem)
                        .frame(width: calcuTextWidth(buttonItem), height: calcuHeight(), alignment: buttonTextAlignment(buttonItem))
                        .foregroundColor(buttonTextColor(buttonItem))
                        .font(.system(size: calcuFontSize(buttonItem), weight: calcuFontWeight(buttonItem)))
                }
            }
    }
    
    // 버튼의 너비를 계산하는 함수
    func calcuWidth(_ item: CalculatorButton) -> CGFloat {
        switch item {
        case .zero:
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2 + 6
        default:
            return (UIScreen.main.bounds.width - (5 * 12)) / 4
        }
    }
    
    // 버튼의 텍스트 너비를 계산하는 함수 ( 0 의 경우 라인을 맞추기 위하여 별도의 함수 생성 )
    func calcuTextWidth(_ item: CalculatorButton) -> CGFloat {
        switch item {
        case .zero:
            return ((UIScreen.main.bounds.width - 5 * 12)) / 3
        default:
            return (UIScreen.main.bounds.width - (5 * 12)) / 4
        }
    }
    
    // 버튼의 높이를 계산하는 함수
    func calcuHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
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
    
    // 버튼 내부 텍스트를 설정하는 함수
    func buttonTextColor(_ item: CalculatorButton) -> Color {
        switch item {
        case .clear, .negative, .modular:
            return .black
        default:
            return .white
        }
    }
    
    // 버튼 내부 텍스트의 정렬을 계산
    func buttonTextAlignment(_ item: CalculatorButton) -> Alignment {
        switch item {
        case .zero:
            return .leading
        default:
            return .center
        }
    }
    
    // 버튼내부 텍스트의 폰트 사이즈 설정하는 함수
    func calcuFontSize(_ item: CalculatorButton) -> CGFloat {
        switch item {
        case .negative, .modular:
            return 30
        case .clear, .divide, .multiple, .minus, .plus, .equal:
            return 35
        default:
            return 45
        }
    }
    
    // 버튼내부 텍스트의 폰트 굵기 설정하는 함수
    func calcuFontWeight(_ item: CalculatorButton) -> Font.Weight {
        switch item {
        case .negative, .modular, .clear:
            return .medium
        case .divide, .multiple, .minus, .plus, .equal:
            return .semibold
        default:
            return .regular
        }
    }
}
