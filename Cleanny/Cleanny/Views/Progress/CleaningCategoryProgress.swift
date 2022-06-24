//
//  MainCleaningCategory.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/12.
//

import SwiftUI

struct CleaningCategoryProgress: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Clean.index, ascending: true)],
        animation: .default)
    private var cleans: FetchedResults<Clean>
    
//    @EnvironmentObject var cleaning: CleaningDataStore
    
    @Binding var index: Int
    @Binding var isCleaning: Bool
    @Binding var complateText: String
    
//    var filteredCleaning: [Cleaning] {
//        cleaning.list.filter {category in
//            category.activated
//        }
//    }
    var filteredCleaning: [Clean] {
        cleans.filter {category in
            category.activated
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(filteredCleaning) {category in
                ZStack {
                    CircularProgress(cleaning: category)
                    CleaningButtonView(
                        cleaning: category, isCleaning: $isCleaning, complateText: $complateText, progress: category.currentPercent
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}
