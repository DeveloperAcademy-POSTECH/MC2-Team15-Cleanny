//
//  SettingModalView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/10.
//

import SwiftUI

struct SettingModalView: View {
    @Binding var showModal: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var cleaning: CleaningDataStore
    
    
    var body: some View {
        ZStack {
            Color("MBackground").ignoresSafeArea()
            ScrollView() {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Button(action: {
                            showModal.toggle()
                            cleaning.isUpdate.toggle()
                            
                        }, label: {
                            Text("완료")
                                .modalButton()
                        })
                    }
                    
                    Text("청소 선택")
                        .modalTitle()
                    
                    CleaningCategoryView()
                    Spacer(minLength: 30)
                    
                    Text("주기 설정")
                        .modalTitle()
                    
                    SettingSliderView()
                    Spacer()
                }
                .padding()
            }
        }
    }
}

extension Text {
    
    func modalTitle() -> some View {
        self.foregroundColor(Color("MBlack"))
            .font(.system(size: 24))
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
    }
    
    func modalButton() -> some View {
        self.foregroundColor(Color("SBlue"))
            .font(.system(size: 16))
            .fontWeight(.semibold)
    }
}

struct SettingModalView_Previews: PreviewProvider {
    static var previews: some View {
        SettingModalView(showModal: .constant(true))
            .environmentObject(CleaningDataStore())
    }
}
