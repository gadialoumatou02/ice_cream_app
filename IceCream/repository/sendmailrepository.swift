//
//  sendmailrepository.swift
//  IceCream
//
//  Created by gadje on 15/12/2025.
//

import Foundation

protocol SendMailService {
    var mailToSend: StockMail? { get set }
    var errorMessage: String { get set }
    func requestMail(to: String, subject: String, body: String)
    func clearMail()
    func clearError()
}
