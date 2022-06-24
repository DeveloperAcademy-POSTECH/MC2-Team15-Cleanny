//
//  CompleteOnboardingView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/17.
//

import SwiftUI

struct CompleteOnboardingView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("Home")
                    .foregroundColor(Color("MBlue"))
                Text("캐릭터 탭")
            }
            Text("버튼을 길게 눌러\n청소를 완료할 수 있어요")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            Spacer()
                .frame(height: 20.0)
            Image("Onboard_Character")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
                .frame(height: 50.0)

        }
    }
}

struct CompleteOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteOnboardingView()
    }
}
