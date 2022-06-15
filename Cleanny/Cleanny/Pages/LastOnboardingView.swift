//
//  LastOnboardingView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/15.
//

import SwiftUI

struct LastOnboardingView: View {
    
    @Binding var firstLaunching: Bool
    
    var body: some View {
        VStack {
            Text("온보딩 테스트 페이지")
            
            Button {
                firstLaunching.toggle()
            } label: {
                Text("시작하기")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color("MBlue"))
                    .cornerRadius(10)
            }
        }
    }
}
