//
//  LaunchScreen.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/15.
//

import SwiftUI
import SDWebImageSwiftUI

struct LaunchView: View {
    
    @State var animationFinished: Bool = false
    @State var animationStarted: Bool = true
    
    var body: some View {
        ZStack {
            ContentView()
            
            Color("MBackground")
                .edgesIgnoringSafeArea(.all)
            ZStack {
                if animationStarted {
                        AnimatedImage(url: getLogoURL())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                } else {
                    Image("Launch")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .animation(.none, value: animationFinished)
        }
        .opacity(animationFinished ? 0 : 1)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animationStarted = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        animationFinished = true
                    }
                }
            }
        }
    }
    
    func getLogoURL() -> URL {
        let bundle = Bundle.main.path(forResource: "Launch", ofType: "gif")
        let url = URL(fileURLWithPath: bundle ?? "")
        
        return url
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
