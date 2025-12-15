//
//  flavourstockview.swift
//  IceCream
//
//  Created by gadje on 12/12/2025.
//

import Foundation
import SwiftUI

struct FlavourStockView: View {
    @Binding var flavour: Flavour

    @StateObject private var flavourRepo = Injector.flavourRepository
    @StateObject private var formatRepo  = Injector.formatRepository
    @StateObject private var extraRepo   = Injector.extraRepository

    @StateObject private var stockService = FlavourStockService()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(flavour.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            HStack(spacing: 16) {
                Image(flavour.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)

                Text("\(flavour.name) flavour is empty")
                    .font(.headline)

                Spacer()
            }

            // Signature + Order (désactivé quand showAllItems == true)
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Signature")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    TextField("Signature", text: $stockService.signature)
                        .textFieldStyle(.roundedBorder)
                }

                Button("Order") {
                    let text = stockService.orderTextForOneFlavour(flavourName: flavour.name)
                    stockService.openGeneratedText(text)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .disabled(stockService.showAllItems)
                .opacity(stockService.showAllItems ? 0.4 : 1.0)
            }

            // Check all items / Collapse other items
            Button(stockService.showAllItems ? "Collapse other items" : "Check all items") {
                stockService.showAllItems.toggle()

                if stockService.showAllItems {
                    // Le parfum affiché en haut est sélectionné et désactivé
                    let lockedID = stockService.itemID(prefix: "flavour", name: flavour.name)
                    stockService.selectedItemIDs.insert(lockedID)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)

            // Liste des items quand showAllItems == true
            if stockService.showAllItems {
                VStack(alignment: .leading, spacing: 10) {

                    // Flavours
                    ForEach(flavourRepo.flavours) { f in
                        let id = stockService.itemID(prefix: "flavour", name: f.name)
                        let locked = (f.name == flavour.name)

                        HStack {
                            Toggle(isOn: Binding(
                                get: { stockService.selectedItemIDs.contains(id) },
                                set: { newValue in
                                    if newValue { stockService.selectedItemIDs.insert(id) }
                                    else { stockService.selectedItemIDs.remove(id) }
                                }
                            )) {
                                Text(f.name)
                                    .fontWeight(locked ? .semibold : .regular)
                            }
                            .disabled(locked)

                            Spacer()

                            Text("\(f.stock) ml")
                                .foregroundColor(.secondary)
                        }
                    }

                    Divider()

                    // Formats
                    ForEach(formatRepo.formats, id: \.name) { fmt in
                        let id = stockService.itemID(prefix: "format", name: fmt.name)

                        HStack {
                            Toggle(isOn: Binding(
                                get: { stockService.selectedItemIDs.contains(id) },
                                set: { newValue in
                                    if newValue { stockService.selectedItemIDs.insert(id) }
                                    else { stockService.selectedItemIDs.remove(id) }
                                }
                            )) {
                                Text(fmt.name)
                            }

                            Spacer()

                            // Si tu n'as pas fmt.stock, remplace par un texte fixe
                            Text("\(fmt.stock)")
                                .foregroundColor(.secondary)
                        }
                    }

                    Divider()

                    // Extras
                    ForEach(extraRepo.extras, id: \.name) { e in
                        let id = stockService.itemID(prefix: "extra", name: e.name)

                        HStack {
                            Toggle(isOn: Binding(
                                get: { stockService.selectedItemIDs.contains(id) },
                                set: { newValue in
                                    if newValue { stockService.selectedItemIDs.insert(id) }
                                    else { stockService.selectedItemIDs.remove(id) }
                                }
                            )) {
                                Text(e.name)
                            }

                            Spacer()

                            // Si tu n'as pas e.stock + e.unit, remplace par un texte fixe
                            Text("\(e.stock) \(e.unit)")
                                .foregroundColor(.secondary)
                        }
                    }

                    // Order en bas
                    Button("Order") {
                        let text = stockService.orderTextForSelectedItems(
                            flavours: flavourRepo.flavours,
                            formats: formatRepo.formats,
                            extras: extraRepo.extras
                        )
                        stockService.openGeneratedText(text)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                    .padding(.top, 8)
                }
                .padding(.top, 6)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Stock")
        .sheet(isPresented: $stockService.showTextSheet) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Generated message")
                    .font(.headline)

                ScrollView {
                    Text(stockService.generatedText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                }

                Button("Close") { stockService.showTextSheet = false }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
            }
            .padding()
        }
    }
}
