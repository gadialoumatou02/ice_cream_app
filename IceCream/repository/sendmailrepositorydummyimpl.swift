//
//  sendmailrepositorydummyimpl.swift
//  IceCream
//
//  Created by gadje on 15/12/2025.
//

import Foundation
import MessageUI

class SendMailRepositoryDummyImpl: ObservableObject, SendMailService {

    @Published var mailToSend: StockMail? = nil
    @Published var errorMessage: String = ""

    func requestMail(to: String, subject: String, body: String) {
        if MFMailComposeViewController.canSendMail() {
            mailToSend = StockMail(to: to, subject: subject, body: body)
        } else {
            errorMessage = "Mail not available. Configure Mail on this device."
        }
    }

    func clearMail() { mailToSend = nil }
    func clearError() { errorMessage = "" }
}
