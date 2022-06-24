//
//  SettingSlider.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/10.
//

import SwiftUI

struct SettingSlider: View {
    
    @ObservedObject var cleaning: Clean
//    @ObservedObject var cleaning: Cleaning
    
    
    var body: some View {
        HStack {
            Image("\(cleaning.imageName ?? "")")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(cleaning.activated ? Color("MBlue") : Color("MGray"))
                .frame(width: 24.0, height: 24.0)
            
            Text("\(Int(cleaning.cycle))일")
                .foregroundColor(Color("DGray"))
                .frame(width: 30, height: 24.0)
            
            Slider(value: $cleaning.cycle, in: 1...7, step: 1)
                .accentColor(cleaning.activated ? Color("MBlue") : Color("MGray"))
                .disabled(!cleaning.activated)
        }
        .padding(.vertical, 5.0)
    }
}
