//
//  OnboardingView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/14.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var firstLaunching: Bool
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            VStack {
                if selection<10 {
                    HStack {
                        Spacer()
                        Button("건너뛰기") {
                            selection = 10
                        }
                        .foregroundColor(Color("MBlue"))
                    }
                    .padding(.horizontal)
                    .frame(height: 40.0)
                } else {
                    Spacer()
                        .frame(height: 50.0)
                }
                TabView(selection: $selection) {
                    FirstOnboradingView(number:1, firstLaunching: $firstLaunching) .tag(0)
                    FirstOnboradingView(number:2, firstLaunching: $firstLaunching) .tag(1)
                    //                FirstOnboradingView(number:3, firstLaunching: $firstLaunching) .tag(2)
                    LastOnboardingView(firstLaunching: $firstLaunching) .tag(10)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            LaunchView()
        }
    }
}
//
//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView(firstLaunching: true)
//    }
//}
