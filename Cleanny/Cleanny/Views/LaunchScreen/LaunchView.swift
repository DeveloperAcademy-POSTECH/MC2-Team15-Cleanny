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
    @State var removeGIF = false
    
    var body: some View {
        ZStack {
            ContentView()
            
            ZStack {
                Color("MBackground")
                    .edgesIgnoringSafeArea(.all)
                
                if !removeGIF {
                    ZStack {
                        VStack {
                            AnimatedImage(url: getLogoURL())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Image("LaunchText")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 100)
                        }
                        
                    }
                    .animation(.none, value: animationFinished)
                }
            }
            .opacity(animationFinished ? 0 : 1)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    animationFinished = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    removeGIF = false
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
            .environmentObject(UserDataStore())
            .environmentObject(CleaningDataStore())
    }
}
