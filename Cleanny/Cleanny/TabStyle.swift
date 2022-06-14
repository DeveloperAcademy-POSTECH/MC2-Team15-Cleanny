//
//  TabStyle.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/14.
//

import SwiftUI
import AxisTabView

public struct TabStyle: ATBackgroundStyle {
    
    public var state: ATTabState
    public var color: Color
    public var cornerRadius: CGFloat
    public var marbleColor: Color
    public var radius: CGFloat
    public var depth: CGFloat
    
    @State private var y: CGFloat = 0
    @State private var alpha: CGFloat = 1
    @State private var dynamicRadius: CGFloat = 0
    @State private var dynamicDepth: CGFloat = 0
    
    public init(_ state: ATTabState, color: Color = .white, cornerRadius: CGFloat = 26, marbleColor: Color = .white, radius: CGFloat = 30, depth: CGFloat = 0.8) {
        self.state = state
        self.color = color
        self.cornerRadius = cornerRadius
        self.marbleColor = marbleColor
        self.radius = radius
        self.depth = depth
    }
    
    public var body: some View {
        let tabConstant = state.constant.tab
        ZStack(alignment: .topLeading) {
            Circle()
                .fill(marbleColor)
                .frame(width: radius * 0.5, height: radius * 0.5)
                .offset(x: state.size.width * state.getCurrentDeltaX() - (radius * 0.5) * 0.5, y: y)
                .opacity(alpha)
                .onAppear {
                    y = getCircleY()
                    alpha = 1.0
                    dynamicRadius = radius
                    dynamicDepth = depth
                }
                .onChange(of: depth, perform: { newValue in
                    dynamicDepth = depth
                })
                .onChange(of: radius, perform: { newValue in
                    dynamicRadius = radius
                })
                .onChange(of: state.currentIndex, perform: { newValue in
                    alpha = 0.0
                    withAnimation(.easeInOut(duration: 0.3)) {
                        dynamicRadius = 0
                        dynamicDepth = 0
                        y = state.constant.axisMode == .bottom ? 50 : state.constant.tab.normalSize.height + state.safeAreaInsets.top - 50
                    }
                    withAnimation(.spring(response: 0.32, dampingFraction: 0.5, blendDuration: 0.5).delay(0.2)) {
                        y = getCircleY()
                        alpha = 1.0
                    }
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.5, blendDuration: 0.5).delay(0.32)) {
                        dynamicRadius = radius
                        dynamicDepth = depth
                    }
                })
            ATCurveShape(radius: dynamicRadius, depth: dynamicDepth, position: state.getCurrentDeltaX())
                .fill(color)
                .frame(height: tabConstant.normalSize.height + (state.constant.axisMode == .bottom ? state.safeAreaInsets.bottom : state.safeAreaInsets.top))
                .scaleEffect(CGSize(width: 1, height: state.constant.axisMode == .bottom ? 1 : -1))
                .mask(
                    Rectangle()
                        .customRadius(cornerRadius, corners: .topLeft)
                        .customRadius(cornerRadius, corners: .topRight)
                )
                .shadow(color: Color("SBlue").opacity(0.3),
                        radius: tabConstant.shadow.radius,
                        x: tabConstant.shadow.x,
                        y: tabConstant.shadow.y)
            
        }
        .animation(.easeInOut(duration: 0.3), value: state.currentIndex)
    }
    
    private func getCircleY() -> CGFloat {
        state.constant.axisMode == .bottom ? -((radius * 0.5) * 0.3) : state.constant.tab.normalSize.height + state.safeAreaInsets.top - ((radius * 0.5) * 0.5)
    }
}

extension View {
    func customRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
