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
    var stock: Int
}
// Cup or Cone
struct Format: Identifiable {
    let id = UUID()
    var name: String
    var price: Double
    var stock: Int
}

// Extras
struct Extra: Identifiable {
    let id = UUID()
    var name: String
    var price:  Double
    var stock: Int
    var unite: String
}

struct IceCream {
    var flavor: Flavour
    var format: Format
    var extras: [Extra]
}
