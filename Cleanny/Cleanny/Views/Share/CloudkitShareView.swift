//
//  CloudkitShareView.swift
//  Cleanny
//
//  Created by Jeon Jimin on 2022/06/15.
//

import Foundation
import SwiftUI
import UIKit
import CloudKit

struct CloudkitShareView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode
    let container: CKContainer
    let share: CKShare

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeUIViewController(context: Context) -> some UIViewController {
        let sharingController = UICloudSharingController(share: share, container: container)
        sharingController.availablePermissions = [.allowReadWrite, .allowPrivate]
        sharingController.delegate = context.coordinator
        sharingController.modalPresentationStyle = .none
        return sharingController
    }

    func makeCoordinator() -> CloudkitShareView.Coordinator {
        Coordinator()
    }

    final class Coordinator: NSObject, UICloudSharingControllerDelegate {
        func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
            debugPrint("Error saving share: \(error)")
        }

        func itemTitle(for csc: UICloudSharingController) -> String? {
            "Sharing Example"
        }
    }
}
