//
//  SettingModalView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/10.
//

import SwiftUI

struct SettingModalView: View {
    
    //CoreData
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Clean.index, ascending: true)],
        animation: .default)
    private var cleans: FetchedResults<Clean>
    
//    @EnvironmentObject var cleaning: CleaningDataStore
    
    @Binding var showModal: Bool

    var checkUpdate: Bool = true
    var body: some View {
        ZStack {
            Color("MBackground").ignoresSafeArea()
            
            ScrollView() {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Button(action: {
                            showModal.toggle()
//                            let filterArr = cleaning.list.filter { filterItem in
//                                return filterItem.activated
//                            }
                            let filterArr = cleans.filter { filterItem in
                                return filterItem.activated
                            }
                            
                            filterArr.forEach { item in
                                //업데이트 함수를 작성할 뷰모델 고려해봐야함 각 페이지 마다 함수 작성 중..
//                                cleaning.update(cleaning: item)
                                updateClean(clean: item)
                            }
                            
                        }) {
                            Text("완료")
                                .modalButton()
                        }
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

    func updateClean(clean: Clean?) {
        guard let clean = clean else { return }
        clean.decreaseRate =  1 / (clean.cycle * 864)
        do {
            try viewContext.save()
        }catch{
            viewContext.rollback()
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
