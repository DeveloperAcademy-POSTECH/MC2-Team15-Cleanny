//
//  InfoModalView.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/24.
//

import SwiftUI

struct InfoModalView: View {
    @Binding var isOpenModal: Bool
   
    var body: some View {
        NavigationView {
            ZStack{
                Color("MBackground")
                    .ignoresSafeArea(.all)
            VStack{
                ZStack{
                    Link(
                        destination: URL(string: "https://github.com/airbnb/lottie-ios")!){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("MBlue"))
                                    .frame(width: 350, height: 60)
                                    .opacity(0.5)
                                Text("Lottie") .foregroundColor(Color.white)
                            }
                        }
                }
                ZStack{
                    Link(
                        destination: URL(string: "https://github.com/AppPear/ChartView")!){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("MBlue"))
                                    .frame(width: 350, height: 60)
                                    .opacity(0.5)
                                Text("Chart") .foregroundColor(Color.white)
                            }
                        }
                }
                ZStack{
                    Link(
                        destination: URL(string: "https://github.com/jasudev/AxisTabView")!){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("MBlue"))
                                    .frame(width: 350, height: 60)
                                    .opacity(0.5)
                                Text("TabView")
                                    .foregroundColor(Color.white)
                            }
                        }
                }
                
                Spacer()
            }
            .padding()
            }
            .navigationTitle("License")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isOpenModal.toggle()
                    }, label: {
                        Text("닫기").font(.headline).foregroundColor(Color("MBlack"))
                    })
                }
            }
        }
      
    }
}

