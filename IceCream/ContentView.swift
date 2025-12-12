//
//  ContentView.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//

import SwiftUI

struct ContentView: View {
    @Binding var icecream: IceCream

        var body: some View {
            IceCreamView(icecream: $icecream)
        }

}
