//
//  injector.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//

import Foundation

class Injector {
    static let flavourRepository = FlavourRepositoryDummyImpl()
    static let formatRepository = FormatRepositoryDummyImpl()
    static let extraRepository = ExtraRepositoryDummyImpl()
}
