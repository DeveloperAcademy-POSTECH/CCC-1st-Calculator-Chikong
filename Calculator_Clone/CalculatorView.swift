//
//  ContentView.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/05/27.
//

import SwiftUI

struct CalculatorView: View {
    
    @State private var result = "0"
    
    let calcuButton: [[CalculatorButton]] = [
        [.clear, .negative, .modular, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(result)
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                        .fontWeight(.light)
                }
                .padding()
                
                VStack {
                    ForEach(calcuButton, id:\.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id:\.self) { buttonItem in
                                Button(action: {
                                    // 기능 구현
                                }) {
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
                            }
                        }
                    }
                }
                .padding(.bottom, 30)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
