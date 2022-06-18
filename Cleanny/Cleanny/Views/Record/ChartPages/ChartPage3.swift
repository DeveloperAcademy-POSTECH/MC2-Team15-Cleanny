//
//  ChartPage3.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/15.
//


import SwiftUI
import SwiftUICharts

struct ChartPage3: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MonthHistory.index, ascending: true),NSSortDescriptor(keyPath: \MonthHistory.monthName, ascending: true)
                          ],
        
        animation: .default)
    private var monthData: FetchedResults<MonthHistory>
    

  //  @EnvironmentObject var MonthData: MonthDataStore
    

    var body: some View {


        BarChartView(data: ChartData(values:getChartData(tempMonthArr: monthData)), title: "욕실청소" )
            .padding()
    }
    func getChartData(tempMonthArr: FetchedResults<MonthHistory>)->Array<(String,Double)>{
        let calendar = Calendar.current
        let date = Date()
        let currentMonth = Int(calendar.component(.month, from: date))
        var chartData:Array<(String,Double)> = []
        var tempMonth = 0
        var i:Int = 5
        
        while i >= 0 {
            tempMonth = (currentMonth - 1)
            tempMonth -= i
            i -= 1
            if(tempMonth < 0){
                tempMonth += 12
            }
            
            chartData.append(("\(tempMonthArr[2 * 12 + tempMonth].monthName)",Double(tempMonthArr[2 * 12 + tempMonth].cleaningCount)))
          
//            chartData.append(("\tempMonthArr[(index * 12) + tempMonth].monthName", Int(tempMonthArr[(index * 12) + tempMonth].cleaningCount)))
        }
      
        return chartData
    }

}
