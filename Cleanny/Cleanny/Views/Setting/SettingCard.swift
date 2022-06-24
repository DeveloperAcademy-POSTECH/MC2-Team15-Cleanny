//
//  SettingCard.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/10.
//

import SwiftUI

struct SettingCard: View {
    
//    @ObservedObject var cleaning: Cleaning
    @ObservedObject var cleaning: Clean
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        
        Button(action: {
            cleaning.activated.toggle()
            updateClean()
            
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(cleaning.activated ? Color.white : Color("LGray"))
                    .shadow(color: cleaning.activated ? Color("SBlue").opacity(0.4) : Color("MBlack").opacity(0.2), radius:4 , y:2)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 20.0, height: 20)
                            .foregroundColor(cleaning.activated ? Color("MBlue").opacity(0.8) : Color("DGray"))
                            .padding(7)
                    }
                    
                    Image("\(cleaning.imageName ?? "")")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(cleaning.activated ? Color("MBlue") : Color("DGray"))
                        .frame(width: 45, height: 45)
                    
                    Spacer()
                    
                    Text("\(cleaning.name ?? "")")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("DGray"))
                    
                    Spacer()
                }
            }
        }
    }
    func updateClean() {
        do {
            try viewContext.save()
        }catch{
            viewContext.rollback()
        }
    }
}
