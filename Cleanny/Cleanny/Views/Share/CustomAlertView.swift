//
//  CustomAlert.swift
//  Cleanny
//
//  Created by Jung Yunseong on 2022/06/18.
//

import SwiftUI

struct CustomAlertView: View {
    
    let screenSize = UIScreen.main.bounds
    var title: String = ""
    @Binding var showAlert: Bool
    @State var updateAction: (String) -> ()
    @State var text: String = ""
    @FocusState var isFocused: Bool
    var onDone: (String) -> Void = { _ in }
    var onCancel: () -> Void = { }
    
    var body: some View {
    
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
            Text("새로운 닉네임을 설정해주세요")
                .bold()
//            CustomTextField(text: $text, isFirstResponder: $showAlert)
            TextField("", text: $text)
                .focused($isFocused)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack(spacing: 20) {
                Button(action: {
                    self.showAlert = false
                    UIApplication.shared.endEditing()
                }, label: {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color("MBlue"))
                        .overlay(Text("취소").foregroundColor(.white))
                        .frame(height: 40)
                        
                })
                
                Button(action: {
                    updateAction(text)
                    self.showAlert = false
                    UIApplication.shared.endEditing()
                }, label: {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color("MBlue"))
                        .overlay(Text("저장").foregroundColor(.white))
                        .frame(height: 40)
                })
            }
            .padding()
            
        }
        .padding()
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.3)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: showAlert ? 0 : screenSize.height)
        .animation(.spring(), value: showAlert)
        .shadow(color: Color("SBlue").opacity(0.3), radius: 6)

    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//struct CustomAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlertView(title: "Add Item", showAlert: .constant(true))
//    }
//}
