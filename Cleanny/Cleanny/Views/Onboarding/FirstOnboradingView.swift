//
//  FirstOnboradingView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/15.
//

import SwiftUI

struct FirstOnboradingView: View {
    @Binding var firstLaunching: Bool

    var number = 1
        
    var body: some View {
        switch number {
        case 1: CharactorOnboardingView()
        case 2: CompleteOnboardingView()
        case 3: GraphOnboardingView()
        case 4: ShareOnboardingView()
        default:
            CharactorOnboardingView()
        }
    }
}
