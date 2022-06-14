//
//  SettingCard.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/10.
//

import SwiftUI

struct SettingCard: View {
    
    @ObservedObject var cleaning: Cleaning
    
    var body: some View {
        
        Button(action: {
            cleaning.activated.toggle()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(cleaning.activated ? Color.white : Color("LGray"))
                    .shadow(color: cleaning.activated ? Color("SBlue").opacity(0.4) : Color("MBlack").opacity(0.2), radius:4 , y:2
                    )
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/, height: 20)
                            .foregroundColor(cleaning.activated ? Color("MBlue").opacity(0.8) : Color("DGray"))
                            .padding(7)
                    }
                    Image("\(cleaning.imageName)")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(cleaning.activated ? /*@START_MENU_TOKEN@*/Color("MBlue")/*@END_MENU_TOKEN@*/ : Color("DGray"))
                        .frame(width: 45, height: 45)
                    Spacer()
                    Text("\(cleaning.name)")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("DGray"))
                    Spacer()
                }
            }
        })
    }
}

struct SettingCard_Previews: PreviewProvider {
    static var previews: some View {
        SettingCard(cleaning: Cleaning(name: "분리수거", imageName:"DisposeTrash", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 100))
            .frame(width: 114, height: 140.0)
    }
}
