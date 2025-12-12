//
//  IceCreamApp.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//

import SwiftUI

@main
struct IceCreamApp: App {
    @State private var icecream = IceCream(
            flavor: Flavour(image: "chocolate", name: "Chocolate", qty: 1),
            format: Format(name: "Cup", price: 0),
            extras: []
        )
    var body: some Scene {
        WindowGroup {
            ContentView(
                icecream: $icecream
            )
        }
    }
}
