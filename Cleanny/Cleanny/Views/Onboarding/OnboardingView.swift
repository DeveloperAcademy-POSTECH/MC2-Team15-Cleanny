//
//  OnboardingView.swift
//  Cleanny
//
//  Created by 한경준 on 2022/06/14.
//

import SwiftUI
struct OnboardingView: View {
    //Clean CoreData
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var vm: CloudkitUserViewModel
    @Binding var firstLaunching: Bool
    
    @State private var selection = 0
    //페이지 개수 설정
    let numberOfPage:Int = 4
    
    var body: some View {
        ZStack {
            Color("MBackground").ignoresSafeArea()
            VStack {
                //온보딩 건너뛰기 버튼
                if selection<(numberOfPage-1) {
                    HStack {
                        Spacer()
                        //MARK: UI error
                        //건너뛰기 버튼 천천히 사라지는 문제 해결해야 함
                        Button {
                            withAnimation(.easeIn(duration: 1)){
                                selection = (numberOfPage-1)
                            }
                        } label: {
                            Text("건너뛰기")
                                .animation(nil)
                        }
                        
                        .foregroundColor(Color("SBlue"))
                    }
                    .padding(.horizontal)
                    .frame(height: 42.0)
                } else {
                    Spacer()
                        .frame(height: 50.0)
                }
                
                //온보딩 컨텐츠 페이지
                TabView(selection: $selection) {
                    ForEach(0..<numberOfPage) { tagNum in
                        FirstOnboradingView(firstLaunching: $firstLaunching, number: tagNum + 1) .tag(tagNum)
                    }
                }
                .transition(.slide)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                //다음, 시작하기 버튼
                Button {
                    withAnimation(.easeIn(duration: 1)){
                        if selection == (numberOfPage-1) {
                            firstLaunching.toggle()
                            addUser(userName: "이름을 설정해주세요")
                            addBasicClean()
                            addMonthHistory()
                        } else {
                            selection += 1
                        }
                    }
                } label: {
                    Text(selection == (numberOfPage-1) ? "시작하기" : "다음")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-60, height: 60)
                        .background(Color("MBlue"))
                        .cornerRadius(10)
                        .animation(nil, value: selection)
                }
                .padding(.bottom)
            }
        }
    }
    func addBasicClean() {
        let list = [
            Cleaning(name: "분리수거", imageName:"DisposeTrash", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 0),
            Cleaning(name: "세탁", imageName:"Laundary", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 1),
            Cleaning(name: "욕실청소", imageName:"ToiletCleaning", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 2),
            Cleaning(name: "바닥청소", imageName:"FloorCleaning", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 3),
            Cleaning(name: "설거지", imageName:"DishWashing", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 4),
            Cleaning(name: "정리정돈", imageName:"TidyUp", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 5)
        ]
        withAnimation {
            list.forEach { cleaning in
                let newClean = Clean(context: viewContext)
                newClean.name = cleaning.name
                newClean.imageName = cleaning.imageName
                newClean.activated = cleaning.activated
                newClean.cycle = cleaning.cycle
                newClean.decreaseRate = cleaning.decreaseRate
                newClean.currentPercent = cleaning.currentPercent
                newClean.savedTime = cleaning.savedTime
                newClean.index = Int16(cleaning.index)
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
    func addUser(userName: String) {
        withAnimation {
            let newUser = User(context: viewContext)
            newUser.name = userName
            newUser.totalPercentage = 99.9
            newUser.denominator = 1.0
            newUser.numerator = 1

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    func addMonthHistory() {
        let indexArr = [0,1,2,3,4,5]
        let monthNameArr = [1,2,3,4,5,6,7,8,9,10,11,12]
        
        withAnimation {
            indexArr.forEach{
                index in
                monthNameArr.forEach{
                    name in
                    let newMonthHistory = MonthHistory(context: viewContext)
                    newMonthHistory.monthName = Int64(name) 
                    newMonthHistory.index = Int64(index)
                    newMonthHistory.cleaningCount = 0
                }
            }

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}
//
//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView(firstLaunching: true)
//    }
//}
