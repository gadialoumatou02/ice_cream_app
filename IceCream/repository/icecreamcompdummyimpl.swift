//
//  icecreamcompdummyimpl.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//

import Foundation
class FlavourRepositoryDummyImpl: ObservableObject, FlavourRepository {
    @Published var flavours: [Flavour] = [
        Flavour(image: "chocolate", name: "Chocolate", qty: 1, stock: 10),
        Flavour(image: "vanilla", name: "Vanilla", qty: 0, stock:5),
        Flavour(image: "pistachio", name: "Pistachio", qty: 0, stock:0),
    ]
    
    func consumeSelections() {
        for i in flavours.indices {
            let s = flavours[i].qty
            if s > 0 {
                flavours[i].stock = max(0, flavours[i].stock - s)
                flavours[i].qty = 0
            }
        }
    }
}

class FormatRepositoryDummyImpl: ObservableObject, FormatRepository {
    @Published var formats: [Format] = [
        Format(name: "Cup", price: 0.0, stock: 7),
        Format(name: "Cone", price: 1.0, stock: 7),
    ]
}

class ExtraRepositoryDummyImpl: ObservableObject, ExtraRepository {
    @Published var extras: [Extra] = [
        Extra(name: "Whipped cream", price: 0.95, stock: 150, unite: "ml"),
        Extra(name: "Hazelnuts", price: 1.30, stock: 100, unite: "g"),
    ]
}


