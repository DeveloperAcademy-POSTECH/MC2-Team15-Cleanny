//
//  CleaningDataStore.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/12.
//

import SwiftUI

class CleaningDataStore: ObservableObject {
    
    @Published var list: [Cleaning]
    @Published var isUpdate = false

    @Published var charcterArr = ["Heit", "Cry", "Laugh", "Love"]

    
    init() {
        list = [
            Cleaning(name: "분리수거", imageName:"DisposeTrash", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 0),
            Cleaning(name: "세탁", imageName:"Laundary", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 1),
            Cleaning(name: "욕실청소", imageName:"ToiletCleaning", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 2),
            Cleaning(name: "바닥청소", imageName:"FloorCleaning", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 3),
            Cleaning(name: "설거지", imageName:"DishWashing", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 4),
            Cleaning(name: "정리정돈", imageName:"TidyUp", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 5)
        ]
    }
    
    func update(cleaning: Cleaning?) {
        guard let cleaning = cleaning else { return }
        
        cleaning.decreaseRate =  1 / (cleaning.cycle * 864)
        
    }
}
