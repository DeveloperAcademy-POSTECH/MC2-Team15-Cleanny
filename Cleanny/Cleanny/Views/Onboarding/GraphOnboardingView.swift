//
//  GraphOnboardingView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/17.
//

import SwiftUI

struct GraphOnboardingView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("Chart")
                    .foregroundColor(Color("MBlue"))
                Text("통계 탭")
            }
            Text("6개월 동안의 청소 통계를\n확인할 수 있어요")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            Spacer()
                .frame(height: 20.0)
            Image("Onboard_Chart")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
                .frame(height: 50.0)
        }
    }
}

struct GraphOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        GraphOnboardingView()
    }
}
