//
//  ContentView.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/08.
//

import SwiftUI
import CoreData
import AxisTabView  

struct ContentView: View {
    
    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init(normalSize: CGSize(width: 50, height: 80)))
    @State private var cornerRadius: CGFloat = 26
    @State private var radius: CGFloat = 30
    @State private var depth: CGFloat = 0.8
    @State private var color: Color = .accentColor
    @State private var marbleColor: Color = .accentColor

    var body: some View {
            GeometryReader { proxy in
                AxisTabView(selection: $selection, constant: constant) { state in
                    if constant.axisMode == .bottom {
                        ATBeadStyle(state,
                                      color: color,
                                      cornerRadius: cornerRadius,
                                      marbleColor: marbleColor,
                                      radius: radius,
                                      depth: depth)
                    }
                } content: {
                    ControlView(selection: $selection,
                                constant: $constant,
                                cornerRadius: $cornerRadius,
                                radius: $radius,
                                depth: $depth,
                                color: $color,
                                marbleColor: $marbleColor,
                                tag: 0,
                                systemName: "Home",
                                safeArea: proxy.safeAreaInsets)
                    ControlView(selection: $selection,
                                constant: $constant,
                                cornerRadius: $cornerRadius,
                                radius: $radius,
                                depth: $depth,
                                color: $color,
                                marbleColor: $marbleColor,
                                tag: 1,
                                systemName: "Calendar",
                                safeArea: proxy.safeAreaInsets)
                    ControlView(selection: $selection,
                                constant: $constant,
                                cornerRadius: $cornerRadius,
                                radius: $radius,
                                depth: $depth,
                                color: $color,
                                marbleColor: $marbleColor,
                                tag: 2,
                                systemName: "Share",
                                safeArea: proxy.safeAreaInsets)
                }
            }
            .animation(.easeInOut, value: constant)
            .animation(.easeInOut, value: radius)
            .animation(.easeInOut, value: depth)
            .animation(.easeInOut, value: marbleColor)
            .animation(.easeInOut, value: cornerRadius)
            .navigationTitle("Screen \(selection + 1)")
        }
    
    struct ControlView: View {
            
            @Binding var selection: Int
            @Binding var constant: ATConstant
            @Binding var cornerRadius: CGFloat
            @Binding var radius: CGFloat
            @Binding var depth: CGFloat
            @Binding var color: Color
            @Binding var marbleColor: Color
            
            let tag: Int
            let systemName: String
            let safeArea: EdgeInsets
            
            var body: some View {
                ZStack {
                    Rectangle()
                        .fill(.white)
                    switch(tag){
                    case 0 :
                        CharacterView()
                    case 1:
                        RecordView()
                    case 2 :
                       CharacterView()
                    default:
                        CharacterView()
                    }
                }
                .tabItem(tag: tag, normal: {
                    TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
                }, select: {
                    TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
                })
            }
            
        }

        struct TabButton: View {
            
            @Binding var constant: ATConstant
            @Binding var selection: Int
            
            let tag: Int
            let isSelection: Bool
            let systemName: String
            
            @State private var y: CGFloat = 0
            
            var content: some View {
                ZStack(alignment: .leading) {
                    Image(uiImage: UIImage(named: systemName)!)
                        .resizable()
                        .scaledToFit()
                        .font(.system(size: 24))
                        .padding(10)
                }
                .foregroundColor(isSelection ? Color.white : Color("Unselected"))
                .clipShape(Capsule())
                .offset(y: y)
                .onAppear {
                    if isSelection {
                        withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                            y = constant.axisMode == .top ? -18 : 18
                        }
                        withAnimation(.easeInOut(duration: 0.3).delay(0.4)) {
                            y = constant.axisMode == .top ? -15 : 15
                        }
                    }else {
                        y = 0
                    }
                }
            }
            var body: some View {
                content
            }
        }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
