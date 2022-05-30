//
//  ContentView.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/05/27.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var calculatorData: CalculatorData
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(calculatorData.valueText)
                        .foregroundColor(.white)
                        .font(.system(size: 95))
                        .fontWeight(.light)
                        .minimumScaleFactor(0.5)
                }
                .padding()
                
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
