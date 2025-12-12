//
//  icecreamrepository.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//

import Foundation

protocol FlavourRepository {
    var flavours: [Flavour] {get}

}

protocol FormatRepository {
    var formats: [Format] {get}
}

protocol ExtraRepository {
    var extras: [Extra] {get}

}
