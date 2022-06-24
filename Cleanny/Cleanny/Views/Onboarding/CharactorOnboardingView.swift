//
//  CharactorOnboardingView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/17.
//

import SwiftUI

struct CharactorOnboardingView: View {
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("Home")
                    .foregroundColor(Color("MBlue"))
                Text("캐릭터 탭")
            }
            Text("청소 상태에 따라 캐릭터의 기분이 달라져요")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            Spacer()
            VStack {
                HStack {
                    Image("Love")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    Image("Laugh")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
            }
            VStack {
                HStack {
                    Image("Cry")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    Image("Heit")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
            }
            Spacer()
            Spacer()
                .frame(height: 50.0)
        }
    }
}

struct CharactorOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        CharactorOnboardingView()
    }
}
