//
//  SettingSliderView.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/11.
//

import SwiftUI

struct SettingSliderView: View {
    
//    @EnvironmentObject var cleaning: CleaningDataStore
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Clean.index, ascending: true)],
        animation: .default)
    private var cleans: FetchedResults<Clean>
    
    var body: some View {
        VStack {
//            ForEach(cleaning.list) { category in
//                SettingSlider(cleaning: category)
//            }
            ForEach(cleans) { category in
                SettingSlider(cleaning: category)
            }
        }
    }
}
