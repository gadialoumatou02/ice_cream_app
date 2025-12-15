//
//  sendmailview.swift
//  IceCream
//
//  Created by gadje on 15/12/2025.
//

import Foundation
import SwiftUI
import MessageUI

struct SendMailView: UIViewControllerRepresentable {

    let to: String
    let subject: String
    let body: String

    // ✅ le contrôle de fermeture vient de la View parente
    @Binding var isPresented: Bool

    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var isPresented: Bool

        init(isPresented: Binding<Bool>) {
            _isPresented = isPresented
        }

        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            // ✅ fermeture native
            isPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients([to])
        vc.setSubject(subject)
        vc.setMessageBody(body, isHTML: false)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: Context
    ) {}
}

