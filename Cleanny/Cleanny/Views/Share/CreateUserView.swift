//
//  CreateUserView.swift
//  Cleanny
//
//  Created by 이채민 on 2022/06/14.
//

//import SwiftUI
//
//struct CreateUserView: View {
//    @State private var nameInput: String = ""
//    @State private var totalPerInput: Double = 100
//
//    let onAdd: ((String, Double) async throws -> Void)?
//
//    var body: some View {
//        NavigationView {
//            TextField("이름을 입력하세요", text: $nameInput)
//                .textContentType(.name)
//                .toolbar {
//                    ToolbarItem(placement: .confirmationAction) {
//                        Button("Save", action: {
//                            Task { try? await onAdd?(nameInput, totalPerInput)}
//                        })
//                        .disabled(nameInput.isEmpty)
//                    }
//                }
//        }
//    }
//}
