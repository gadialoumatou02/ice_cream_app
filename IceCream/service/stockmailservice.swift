//
//  stockmailservice.swift
//  IceCream
//
//  Created by gadje on 15/12/2025.
//

import Foundation
import MessageUI


struct StockMail {
    let to: String
    let subject: String
    let body: String
}


struct StockMailService {


    func canSendMail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }


    func mailForOneFlavour(flavourName: String, signature: String) -> StockMail {
        let body = """
        Hi,
        Please order the following:
        * \(flavourName) icecream
        \(signature)
        """
        return StockMail(to: "order@icecream.com", subject: "Order", body: body)
    }


    func mailForSelectedItems(lines: [String], signature: String) -> StockMail {
        var bodyLines: [String] = []
        bodyLines.append("Hi,")
        bodyLines.append("Please order the following:")
        for l in lines { bodyLines.append("* \(l)") }
        bodyLines.append(signature)


        return StockMail(to: "order@icecream.com", subject: "Order", body: bodyLines.joined(separator: "\n"))
    }
}




