//
//  ShareView.swift
//  Cleanny
//
//  Created by 이채민 on 2022/06/10.
//

import SwiftUI

struct ShareView: View {
    
    var friends = ["주주", "쿠키", "치콩", "엘리", "할로겐", "네이스", "버킬", "창브로", "밀키"]
    var percentageDic = ["주주": 0.8, "쿠키": 0.6, "치콩": 0.3, "엘리": 0.2, "할로겐": 1, "네이스": 0.7, "버킬": 0.5, "창브로": 0.1, "밀키": 0.9]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("MBackground")
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    ScrollView() {
                        LazyVGrid (columns: columns) {
                            ForEach(friends, id: \.self) { friend in
                                CardView(name: friend, percentage: percentageDic[friend]!)
                            }
                        }
                        .padding(.horizontal)
                        Spacer(minLength: 50)
                    }
                    Spacer(minLength: 60)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        Text("공유").font(.headline)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            // 친구 추가 모달 or 알림
                        } label: {
                            Image(uiImage: UIImage(named: "AddFriend")!)
                                .foregroundColor(Color("MBlue"))
                        }
                    }
                }
            }
            
        }
    }
}

struct CardView: View {
    
    var name: String
    var percentage: Double
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: Color("ShadowBlue"), radius: 2, x: 0, y: 2)
            
            VStack {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(Color(percentage > 0.25 ? "MBlue" : "MRed").opacity(0.1))
                    Circle()
                        .fill(Color(percentage > 0.25 ? "MBlue" : "MRed").opacity(0.1))
                        .padding()
                    Circle()
                        .fill(Color(percentage > 0.25 ? "MBlue" : "MRed").opacity(0.1))
                        .padding()
                        .padding()
                    
                    Image("Heit")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth:100, maxWidth: 150)
                }
                .padding(.top)
                
                Text(name)
                    .bold()
                
                ProgressBar(percentage: percentage)
                    .padding([.bottom, .trailing, .leading])
            }
        }
    }
}

struct ProgressBar: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var percentage: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color("LGray"))
                    .frame(height: 14)
                    .overlay(
                        Capsule() // main capsule innerShadow
                            .stroke(.white, lineWidth: 4)
                            .shadow(color: Color("MBlack").opacity(0.2), radius: 4, x: 3, y: 4)
                            .clipShape(Capsule())
                            .shadow(color: .white.opacity(0.3), radius: 4, x: -3, y: -4)
                            .clipShape(Capsule())
                    )
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(percentage > 0.25 ? "GMBlue" : "GMRed"), Color(percentage > 0.25 ? "MBlue" : "MRed")]), startPoint: .leading, endPoint: .trailing))
                    .frame(height: 10)
                    .frame(maxWidth: geometry.size.width * percentage)
            }
        }
        .frame(height: 10)
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        //        ShareView()
        CardView(name: "주주", percentage: 0.5)
        ProgressView()
    }
}
