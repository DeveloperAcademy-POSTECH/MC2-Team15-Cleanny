//
//  CleaningCategoryView.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/11.
//

import SwiftUI

struct CleaningCategoryView: View {
    
    @EnvironmentObject var cleaning: CleaningDataStore
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(cleaning.list) {category in
                SettingCard(cleaning: category)
                    .frame(height: 140.0)
            }
        }
    }
}

struct CleaningCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CleaningCategoryView()
    }
}
