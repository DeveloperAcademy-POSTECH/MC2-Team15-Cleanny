//
//  ShareOnboardingView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/17.
//

import SwiftUI

struct ShareOnboardingView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("Share")
                    .foregroundColor(Color("MBlue"))
                Text("공유 탭")
            }
            Text("나의 청소 상태를 친구들과 공유해보세요")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            Spacer()
                .frame(height: 20.0)
            Image("Onboard_Share")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
                .frame(height: 50.0)
        }
    }
}

struct ShareOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ShareOnboardingView()
    }
}
