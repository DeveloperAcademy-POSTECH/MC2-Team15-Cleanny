//
//  CircularProgressBarView.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/11.
//

import SwiftUI

struct CircularProgressBarView: View {
    
    @Binding var progress: Double
    @Binding var lineWidth: Double
    
    var body: some View {
        
        let angularGradientProgress = AngularGradient(
            gradient: Gradient(colors: [progress <= 25 ? Color("GMRed") : Color("GMBlue"), progress <= 25 ? Color("MRed") : Color("MBlue")]),
            center: .center,
            startAngle: .degrees(0),
            endAngle: .degrees(3.6 * progress))
        
        ZStack {
            Circle() // gradient progress bar
                .trim(from: 0, to: CGFloat(self.progress * 0.01))
                .stroke(angularGradientProgress, style: StrokeStyle(lineWidth: 9, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 85, height: 85)
            Circle() // progress bar innerShadow
                .frame(width: 98.5, height: 98.5)
                .foregroundColor(.clear)
                .overlay(
                    Circle()
                        .trim(from: 0, to: CGFloat(self.progress * 0.01))
                        .stroke(.white.opacity(0.4), lineWidth: 4)
                        .rotationEffect(Angle(degrees: -90))
                        .shadow(color: .white, radius: 2, x: 3, y: 4)
                        .clipShape(Circle().trim(from: 0, to: CGFloat(self.progress * 0.01)))
                )
            Circle() // progress bar inner circle
                .trim(from: 0, to: CGFloat(self.progress * 0.01))
                .foregroundColor(Color("MBackground"))
                .rotationEffect(Angle(degrees: -90))
                .shadow(color: .white.opacity(0.4), radius: 2, x: 3, y: 4)
                .frame(width: CGFloat(95.5 - lineWidth), height: CGFloat(95.5 - lineWidth))
        }
    }
}

struct CircularProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBarView(progress: .constant(Double(Int.random(in: 0...100))), lineWidth: .constant(20))
    }
}
