//
//  stockmail.swift
//  IceCream
//
//  Created by gadje on 15/12/2025.
//

import Foundation

struct SendMail: Identifiable{
    let id = UUID()
    var to: String
    var subject: String
    var body: String
}
