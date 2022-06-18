//
//  ChartPage6.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/15.
//


import SwiftUI
import SwiftUICharts

struct ChartPage6: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MonthHistory.index, ascending: true),NSSortDescriptor(keyPath: \MonthHistory.monthName, ascending: true)
                         ],
        
        animation: .default)
    private var monthData: FetchedResults<MonthHistory>
    
    
    //  @EnvironmentObject var MonthData: MonthDataStore
    
    
    var body: some View {
        
        
        BarChartView(data: ChartData(values:getChartData(tempMonthArr: monthData)), title: "정리정돈" )
            .padding()
    }
    func getChartData(tempMonthArr: FetchedResults<MonthHistory>)->Array<(String,Double)>{
        let calendar = Calendar.current
        let date = Date()
        let currentMonth = Int(calendar.component(.month, from: date))
        var chartData:Array<(String,Double)> = []
        var tempMonth = 0
        var i:Int = 11
        
        while i >= 0 {
            if(i>5){
                tempMonth = (currentMonth - 1)
                tempMonth -= i
                i -= 1
                if(tempMonth < 0){
                    tempMonth += 12
                }
                tempMonthArr[5 * 12 + tempMonth].cleaningCount = 0
            }
            else{
                tempMonth = (currentMonth - 1)
                tempMonth -= i
                i -= 1
                if(tempMonth < 0){
                    tempMonth += 12
                }
                
                chartData.append(("\(tempMonthArr[5 * 12 + tempMonth].monthName)",Double(tempMonthArr[5 * 12 + tempMonth].cleaningCount)))
            }
            //            chartData.append(("\tempMonthArr[(index * 12) + tempMonth].monthName", Int(tempMonthArr[(index * 12) + tempMonth].cleaningCount)))
        }
        
        return chartData
    }
    
}
