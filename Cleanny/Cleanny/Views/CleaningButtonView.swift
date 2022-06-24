//
//  CleaningButtonView.swift
//  Cleanny
//
//  Created by Hong jeongmin on 2022/06/10.
//

import SwiftUI

// https://github.com/Seogun95/HapticsView/blob/main/HapticsView/ContentView.swift
class HapticManager {
    
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct CleaningButtonView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
   
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MonthHistory.index, ascending: true),NSSortDescriptor(keyPath: \MonthHistory.monthName, ascending: true)
                          ],
        
        animation: .default)

    private var monthData: FetchedResults<MonthHistory>
    
   // @EnvironmentObject var monthData: MonthDataStore
    //    @ObservedObject var cleaning: Cleaning
    @ObservedObject var cleaning: Clean
    
    @GestureState var tap = false
    
    @Binding var isCleaning: Bool
    @Binding var complateText: String
    
    let progress: Double
    
    var body: some View {
        Button(action: {}) {
            Circle()
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .shadow(color: Color("SBlue").opacity(0.3), radius: 4, x: 1, y: 1)
                .scaleEffect(tap ? 1.1 : 1)
                .overlay(
                    Image(cleaning.imageName ?? "")
                        .foregroundColor(progress < 50 ? Color("MRed"): Color("MBlue"))
                )
                .onTapGesture {
                    isCleaning = false
                }
                .simultaneousGesture(LongPressGesture(minimumDuration: 1.5)
                    .updating($tap) { currentState, gestureState, transition in
                        gestureState = currentState
                    }
                                     
                    .onChanged { _ in
                        HapticManager.instance.impact(style: .heavy)
                        isCleaning = true
                    }
                                     
                    .onEnded{ _ in
                        HapticManager.instance.notification(type: .success)
                      //  monthData.addCnt(month: monthData.list[Int(cleaning.index)])
                        let calendar = Calendar.current
                        let date = Date()
                        var currentMonth = Int(calendar.component(.month, from: date))
                        var temp = currentMonth - 1
                         
                        temp = temp + Int(cleaning.index)*12
                        
                        monthData[temp].cleaningCount += Int64(1)
                        
                        
                        do {
                            try viewContext.save()
                        }catch{
                            viewContext.rollback()
                        }
                        withAnimation {
                            let cleanName = cleaning.name ?? ""
                            complateText = "🤍 " + cleanName + " 완료 🤍"
                            cleaning.currentPercent = 100
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            complateText = ""
                            isCleaning = false
                        }
                    }
                )
        }
    }
   
}
