//
//  CharacterView.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/08.
//

import SwiftUI

struct CharacterView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)])
    private var users: FetchedResults<User>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MonthHistory.index, ascending: true)])
    private var monthHistoryData: FetchedResults<MonthHistory>
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Clean.index, ascending: true)],
//        animation: .default)
//    private var cleans: FetchedResults<Clean>
    
//    @EnvironmentObject var userData: UserDataStore
    @EnvironmentObject var cleaning: CleaningDataStore
    
    @Binding var index: Int
    @Binding var isCleaning: Bool
    
    @State private var isUpdatingView: Bool = true
    @State private var complateText = ""
    @State private var showModal = false
    @State private var infoModal = false
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        if(monthHistoryData.isEmpty){}
        else{
        ZStack(alignment: .top) {
            Color("MBackground").ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: { self.infoModal.toggle() })
                    {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .foregroundColor(Color("MBlue"))
                            .padding()
                    }
                    .sheet(isPresented: self.$infoModal) {
                        InfoModalView(isOpenModal:  $infoModal)
                    }

                    Spacer()
                    Button(action: { self.showModal = true })
                    {
                        Image("Setting")
                            .foregroundColor(Color("MBlue"))
                            .padding()
                    }
                    .rotationEffect(.degrees(showModal ? 0 : 360))
                    .animation(Animation.easeInOut(duration: 0.5), value: showModal)
                    .sheet(isPresented: self.$showModal) {
                        SettingModalView(showModal: $showModal)
                            .interactiveDismissDisabled()
                    }
                }
                if(index < 0){
                    Text("주기를 설정해주세요").foregroundColor(Color("MBlack"))
                }
                else{
                ZStack {
                   LottieView(name: isCleaning ? "Cleaning" : cleaning.charcterArr[index])
                    Text("\(complateText)").foregroundColor(Color("MBlack"))
                        .offset(y: -screenHeight / 5)
                }
                .frame(maxHeight: screenHeight / 2.5)
                }
                CleaningCategoryProgress(index: $index, isCleaning: $isCleaning, complateText: $complateText)
                
                Spacer(minLength: screenHeight / 6)
            }
        }
            
        }
//        .onChange(of: returnTP()) { newValue in
//            isUpdatingView.toggle()
//        }
//        .onChange(of: userData.totalPercentage) { newValue in
//            isUpdatingView.toggle()
//        }
    }
    
//    private func returnTP() -> Double {
//        if(!UserDefaults.standard.bool(forKey: "notDoneSetting")) {
//            return users[0].totalPercentage
//        } else {
//            return 0.0
//        }
//    }
}
