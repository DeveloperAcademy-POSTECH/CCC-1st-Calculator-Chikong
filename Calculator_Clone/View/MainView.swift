//
//  MainView.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/05/27.
//

import SwiftUI
import UniformTypeIdentifiers

struct MainView: View {
    @EnvironmentObject var calculatorModel: CalculatorModel
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(calculatorModel.valueText)
                        .foregroundColor(.white)
                        .font(.system(size: 95))
                        .fontWeight(.light)
                        .minimumScaleFactor(0.5)
                        .textSelection(.enabled)
                }
                .padding()
                .gesture(
                    DragGesture()
                        .onChanged{ _ in
                            calculatorModel.dragNumberEditing()
                            calculatorModel.isDrag = true
                        }
                        .onEnded { _ in
                            calculatorModel.isDrag = false
                        }
                )
                
                VStack {
                    CalculatorView()
                }
                .padding(.bottom, 45)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(CalculatorData())
    }
}
