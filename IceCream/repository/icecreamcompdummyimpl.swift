//
//  icecreamcompdummyimpl.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//

import Foundation
class FlavourRepositoryDummyImpl: ObservableObject, FlavourRepository {
    @Published var flavours: [Flavour] = [
        Flavour(image: "chocolate", name: "Chocolate", qty: 1),
        Flavour(image: "vanilla", name: "Vanilla", qty: 0),
        Flavour(image: "pistachio", name: "Pistachio", qty: 0),
    ]
}

class FormatRepositoryDummyImpl: ObservableObject, FormatRepository {
    @Published var formats: [Format] = [
        Format(name: "Cup", price: 0.0),
        Format(name: "Cone", price: 1.0),
    ]
}

class ExtraRepositoryDummyImpl: ObservableObject, ExtraRepository {
    @Published var extras: [Extra] = [
        Extra(name: "Whipped cream", price: 0.95),
        Extra(name: "Hazelnuts", price: 1.30),
    ]
}
