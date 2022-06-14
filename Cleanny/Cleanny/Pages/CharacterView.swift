//
//  CharacterView.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/08.
//

import SwiftUI

struct CharacterView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userData: UserDataStore
    
    @Binding var index: Int
    
    @State private var isUpdatingView: Bool = true
    @State private var complateText = ""
    @State private var showModal = false
    
    let charcterArr = ["Cry", "Heit", "Laugh", "Love"]
    
    var body: some View {
        ZStack {
            Color("MBackground").ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button(action: { self.showModal = true })
                    {
                        Image("Setting")
                            .foregroundColor(Color("MBlue"))
                            .padding()
                    }
                    .sheet(isPresented: self.$showModal) {
                        SettingModalView(showModal: $showModal)
                    }
                }
                Spacer()
                
                ZStack(alignment: .top) {
                    LottieView(name: charcterArr[index])
                    Text("\(complateText)")
                        .offset(y: -20)
                }

                Spacer()
                
                CleaningCategoryProgress(complateText: $complateText)
                Spacer(minLength:  150)
            }
        }
        .onChange(of: userData.totalPercentage) { newValue in
            isUpdatingView.toggle()
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(index: .constant(0))
            .environmentObject(CleaningDataStore())
            .environmentObject(UserDataStore())
    }
}
