//
//  BarChartView.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/12.
//


import SwiftUI

public struct Styles {
    public static let lineChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color.orange,
        secondGradientColor: Color.orange,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleOrangeLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color.orange,
        secondGradientColor: Color.orange,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleNeonBlueLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color.orange,
        secondGradientColor: Color.orange,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let pieChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color.orange,
        secondGradientColor: Color.orange,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
}

public struct BarChartCell : View {
    var value: Double
    var month: String
    var index: Int = 0
    var width: Float
    var numberOfDataPoints: Int
    var cellWidth: Double {
        return Double(width)/(Double(numberOfDataPoints) * 2)
    }
    var accentColor: Color
    var gradient: GradientColor?
    
    @State var scaleValue: Double = 0
    @Binding var touchLocation: CGFloat
    public var body: some View {
        VStack{
            ZStack {
                RoundedCorner(radius: 50, corners:[.topLeft,.topRight,.bottomLeft,.bottomRight])
                    .fill(LinearGradient(gradient: gradient?.getGradient() ?? GradientColor(start: accentColor, end: accentColor).getGradient(), startPoint: .bottom, endPoint: .top))
            }
            .frame(width: CGFloat(self.cellWidth))
            .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
            Text(self.month)
                .foregroundColor(Color("MBlack"))
            
        }
        .onAppear(){
            self.scaleValue = self.value
        }
        .animation(.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0), value: scaleValue)
    }
}


class HapticFeedback {
#if os(watchOS)
    //watchOS implementation
    static func playSelection() -> Void {
        WKInterfaceDevice.current().play(.click)
    }
#elseif os(iOS)
    //iOS implementation
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    static func playSelection() -> Void {
        UISelectionFeedbackGenerator().selectionChanged()
    }
#else
    static func playSelection() -> Void {
        //No-op
    }
#endif
}


struct LabelView: View {
    @Binding var arrowOffset: CGFloat
    @Binding var title:String
    var body: some View {
        VStack{
            ArrowUp().fill(Color.white).frame(width: 20, height: 12, alignment: .center).shadow(color: Color.gray, radius: 8, x: 0, y: 0).offset(x: getArrowOffset(offset:self.arrowOffset), y: 12)
            ZStack{
                RoundedRectangle(cornerRadius: 8).frame(width: 100, height: 32, alignment: .center).foregroundColor(Color.white).shadow(radius: 8)
                Text(self.title).font(.caption).bold()
                ArrowUp().fill(Color.white).frame(width: 20, height: 12, alignment: .center).zIndex(999).offset(x: getArrowOffset(offset:self.arrowOffset), y: -20)
                
            }
        }
    }
    
    func getArrowOffset(offset: CGFloat) -> CGFloat {
        return max(-36,min(36, offset))
    }
}

struct ArrowUp: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width/2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

public struct BarChartRow : View {
    var data: [Double]
    var month : [String]
    var accentColor: Color
    var gradient: GradientColor?
    var maxValue: Double {
        guard let max = data.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }
    
    @Binding var touchLocation: CGFloat
    
    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: (geometry.frame(in: .local).width-22)/CGFloat(self.data.count * 3)){
                ForEach(0..<self.data.count, id: \.self) { i in
                    BarChartCell(value: self.normalizedValue(index: i),
                                 month: self.month[i],
                                 index: i,
                                 width: Float(geometry.frame(in: .local).width - 22),
                                 numberOfDataPoints: self.data.count,
                                 accentColor: self.accentColor,
                                 gradient: self.gradient,
                                 touchLocation: self.$touchLocation)
                    .scaleEffect(self.touchLocation > CGFloat(i)/CGFloat(self.data.count) && self.touchLocation < CGFloat(i+1)/CGFloat(self.data.count) ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                    .animation(.spring(), value: touchLocation)
                    
                }
            }
            .padding([.top, .leading, .trailing,.bottom], 50)
        }
    }
    
    func normalizedValue(index: Int) -> Double {
        return Double(self.data[index])/Double(self.maxValue)
    }
}


public struct GradientColor {
    public let start: Color
    public let end: Color
    
    public init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }
    
    public func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}
public struct ChartForm {
#if os(watchOS)
    public static let small = CGSize(width:120, height:90)
    public static let medium = CGSize(width:120, height:160)
    public static let large = CGSize(width:180, height:90)
    public static let extraLarge = CGSize(width:180, height:90)
    public static let detail = CGSize(width:180, height:160)
#else
    public static let small = CGSize(width:180, height:120)
    public static let medium = CGSize(width:180, height:240)
    public static let large = CGSize(width:360, height:120)
    public static let extraLarge = CGSize(width:350, height:360)
    public static let detail = CGSize(width:180, height:120)
#endif
}

public class ChartData: ObservableObject, Identifiable {
    
    @Published var points: [(String,Double)]
    
    var valuesGiven: Bool = false
    
    var ID = UUID()
    
    public init<N: BinaryFloatingPoint>(points:[N]) {
        self.points = points.map{("", Double($0))}
    }
    
    public init<N: BinaryInteger>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        //   self.valuesGiven = true
    }
    
    public init<N: BinaryFloatingPoint>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        //    self.valuesGiven = true
    }
    
    public init<N: BinaryInteger>(numberValues:[(N,N)]){
        self.points = numberValues.map{(String($0.0), Double($0.1))}
        //     self.valuesGiven = true
    }
    
    public init<N: BinaryFloatingPoint & LosslessStringConvertible>(numberValues:[(N,N)]){
        self.points = numberValues.map{(String($0.0), Double($0.1))}
        //   self.valuesGiven = true
    }
    
    public func onlyPoints() -> [Double] {
        
        return self.points.map{ $0.1 }
    }
}

public class ChartStyle {
    public var backgroundColor: Color
    public var accentColor: Color
    public var gradientColor: GradientColor
    public var textColor: Color
    public var legendTextColor: Color
    public var dropShadowColor: Color
    public weak var darkModeStyle: ChartStyle?
    
    public init(backgroundColor: Color, accentColor: Color, secondGradientColor: Color, textColor: Color, legendTextColor: Color, dropShadowColor: Color){
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.gradientColor = GradientColor(start: accentColor, end: secondGradientColor)
        self.textColor = textColor
        self.legendTextColor = legendTextColor
        self.dropShadowColor = dropShadowColor
    }
    
    public init(backgroundColor: Color, accentColor: Color, gradientColor: GradientColor, textColor: Color, legendTextColor: Color, dropShadowColor: Color){
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.gradientColor = gradientColor
        self.textColor = textColor
        self.legendTextColor = legendTextColor
        self.dropShadowColor = dropShadowColor
    }
    
    public init(formSize: CGSize){
        self.backgroundColor = Color.white
        self.accentColor = Color.orange
        self.gradientColor = GradientColor(start: accentColor, end: Color.orange)
        self.accentColor = Color.blue
        self.legendTextColor = Color.gray
        self.textColor = Color.black
        self.dropShadowColor = Color.gray
    }
}



public struct BarChartView : View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    private var data: ChartData
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var formSize:CGSize
    public var dropShadow: Bool
    public var cornerImage: Image?
    public var valueSpecifier:String
    public var animatedToBack: Bool
    
    @State private var touchLocation: CGFloat = -1.0
    @State private var showValue: Bool = false
    @State private var showLabelValue: Bool = false
    @State private var currentValue: Double = 0 {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
                HapticFeedback.playSelection()
            }
        }
    }
    var isFullWidth:Bool {
        return self.formSize == ChartForm.extraLarge
    }
    public init(data:ChartData, title: String, legend: String? = nil, style: ChartStyle = Styles.barChartStyleOrangeLight, form: CGSize? = ChartForm.extraLarge, dropShadow: Bool? = true, cornerImage:Image? = Image(systemName: "waveform.path.ecg"), valueSpecifier: String? = "%.0f", animatedToBack: Bool = false){
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.formSize = form!
        self.dropShadow = dropShadow!
        self.cornerImage = cornerImage
        self.valueSpecifier = valueSpecifier!
        self.animatedToBack = animatedToBack
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.style.backgroundColor)
                .cornerRadius(20)
                .shadow(color: Color("ShadowBlue"), radius: self.dropShadow ? 8 : 0, y: 4)
            VStack(alignment: .leading){
                HStack{
                    if(!showValue){
                        Text(self.title)
                            .font(.headline)
                            .foregroundColor(self.style.textColor)
                    }else{
                        Text("\(self.currentValue, specifier: self.valueSpecifier)")
                            .font(.headline)
                            .foregroundColor(self.style.textColor)
                    }
                    if(self.formSize == ChartForm.large && self.legend != nil && !showValue) {
                        Text(self.legend!)
                            .font(.callout)
                            .foregroundColor(self.style.accentColor)
                            .transition(.opacity)
                            .animation(.easeOut, value: formSize)
                    }
                    Spacer()
                    self.cornerImage
                        .imageScale(.large)
                        .foregroundColor(self.style.legendTextColor)
                }.padding()
                BarChartRow(data: data.points.map{$0.1}, month: data.points.map{$0.0},
                            accentColor:Color("LSkyBlue"),
                            gradient: GradientColor(start:  Color("LSkyBlue"), end:  Color("LSkyBlue")),
                            touchLocation: self.$touchLocation)
                if self.legend != nil  && self.formSize == ChartForm.medium && !self.showLabelValue{
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.style.legendTextColor)
                        .padding()
                }else if (self.data.valuesGiven && self.getCurrentValue() != nil) {
                    LabelView(arrowOffset: self.getArrowOffset(touchLocation: self.touchLocation),
                              title: .constant(self.getCurrentValue()!.0))
                    .offset(x: self.getLabelViewOffset(touchLocation: self.touchLocation), y: -6)
                    .foregroundColor(self.style.legendTextColor)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .gesture(DragGesture()
            .onChanged({ value in
                self.touchLocation = value.location.x/self.formSize.width
                self.showValue = true
                self.currentValue = self.getCurrentValue()?.1 ?? 0
                if(self.data.valuesGiven && self.formSize == ChartForm.medium) {
                    self.showLabelValue = true
                }
            })
                .onEnded({ value in
                    if animatedToBack {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(Animation.easeOut(duration: 1)) {
                                self.showValue = false
                                self.showLabelValue = false
                                self.touchLocation = -1
                            }
                        }
                    } else {
                        self.showValue = false
                        self.showLabelValue = false
                        self.touchLocation = -1
                    }
                })
        )
        .gesture(TapGesture()
        )
    }
    
    func getArrowOffset(touchLocation:CGFloat) -> Binding<CGFloat> {
        let realLoc = (self.touchLocation * self.formSize.width) - 50
        if realLoc < 10 {
            return .constant(realLoc - 10)
        }else if realLoc > self.formSize.width-110 {
            return .constant((self.formSize.width-110 - realLoc) * -1)
        } else {
            return .constant(0)
        }
    }
    
    func getLabelViewOffset(touchLocation:CGFloat) -> CGFloat {
        return min(self.formSize.width-110,max(10,(self.touchLocation * self.formSize.width) - 50))
    }
    
    func getCurrentValue() -> (String,Double)? {
        guard self.data.points.count > 0 else { return nil}
        let index = max(0,min(self.data.points.count-1,Int(floor((self.touchLocation*self.formSize.width)/(self.formSize.width/CGFloat(self.data.points.count))))))
        return self.data.points[index]
    }
}
