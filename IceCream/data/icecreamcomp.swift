//
//  icecreamcomp.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//
import Foundation
// Parfum
struct Flavour: Identifiable{
    let id = UUID()
    var image: String
    var name: String
    var qty: Int
}
// Cup or Cone
struct Format: Identifiable {
    let id = UUID()
    var name: String
    var price: Double
}

// Extras
struct Extra: Identifiable {
    let id = UUID()
    var name: String
    var price:  Double
}

struct IceCream {
    var flavor: Flavour
    var format: Format
    var extras: [Extra]
}
