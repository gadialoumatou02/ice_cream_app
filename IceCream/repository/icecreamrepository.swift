//
//  icecreamrepository.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//

import Foundation
protocol IceCreamRepository {
    var flavours: [Flavour] {get}
    var formats: [Format] {get}
    var extras: [Extra] {get}

}
