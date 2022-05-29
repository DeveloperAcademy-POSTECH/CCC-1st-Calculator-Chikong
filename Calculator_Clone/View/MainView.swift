//
//  ContentView.swift
//  Calculator_Clone
//
//  Created by Hong jeongmin on 2022/05/27.
//

import SwiftUI

struct MainView: View {
    
    @State private var result = "0"
    
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
                    CalculatorView()
                }
                .padding(.bottom, 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
