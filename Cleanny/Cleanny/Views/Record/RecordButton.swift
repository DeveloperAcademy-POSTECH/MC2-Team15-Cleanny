//
//  RecordButton.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/15.
//

import SwiftUI

struct RecordButton: View {
    
    @ObservedObject var cleaning: Cleaning
    @Binding var index: Int
    
    var body: some View {
        Button(action: {
            index = cleaning.index
        }) {
            Image(cleaning.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("MBlue"))
                .padding()
                .background(
                    Circle()
                        .foregroundColor(.white)
                        .shadow(color: Color("SBlue").opacity(0.3), radius: 5, x: 1, y: 1)
                )
        }
        .frame(width: UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.width/5)
    }
}
