//
//  flavourstockview.swift
//  IceCream
//
//  Created by gadje on 12/12/2025.
//

import Foundation
import SwiftUI

struct FlavourStockView: View {
    let flavourName: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
            Text("\(flavourName) is out of stock")
                .font(.headline)
            Text("Please choose another flavour.")
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("Stock")
    }
}
