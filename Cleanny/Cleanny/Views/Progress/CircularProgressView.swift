//
//  CircularProgressView.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/09.
//


import SwiftUI

struct CircularProgress: View {
    @ObservedObject var cleaning:Clean
//    @ObservedObject var cleaning:Cleaning
    
    let lineWidth: Double = 20
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 98.5, height: 98.5)
                .foregroundColor(Color("LGray"))
                .overlay(
                    Circle()
                        .stroke(Color("MBackground"), lineWidth: 4)
                        .shadow(color: Color("MBlack").opacity(0.2), radius: 4, x: 3, y: 4)
                        .clipShape(Circle())
                        .shadow(color: .white.opacity(0.3), radius: 4, x: -3, y: -4)
                        .clipShape(Circle())
                )
            
            Circle()
                .foregroundColor(Color("MBackground"))
                .shadow(color: Color("MBlack").opacity(0.1), radius: 4, x: 2, y: 4)
                .frame(width: CGFloat(96 - lineWidth), height: CGFloat(96 - lineWidth))
            
            CircularProgressBarView(
                progress: .constant(cleaning.currentPercent),
                lineWidth: .constant(20)
            )
        }
    }
}
