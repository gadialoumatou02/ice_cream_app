//
//  flavourstockservice.swift
//  IceCream
//
//  Created by gadje on 15/12/2025.
//

import Foundation
import Combine

final class FlavourStockService: ObservableObject {

    // UI state (remplace @State)
    @Published var signature: String = "Thanks, MB"
    @Published var showAllItems: Bool = false

    // Sélection des items quand "all items" est affiché
    @Published var selectedItemIDs: Set<String> = []

    // Pour afficher le texte généré
    @Published var generatedText: String = ""
    @Published var showTextSheet: Bool = false

    // MARK: - Helpers

    func itemID(prefix: String, name: String) -> String {
        return prefix + ":" + name
    }

    func openGeneratedText(_ text: String) {
        generatedText = text
        showTextSheet = true
    }

    // MARK: - Order texts

    func orderTextForOneFlavour(flavourName: String) -> String {
        return """
        Hi,
        Please order the following:
        * \(flavourName) icecream
        \(signature)
        """
    }

    func orderTextForSelectedItems(
        flavours: [Flavour],
        formats: [Format],
        extras: [Extra]
    ) -> String {

        var lines: [String] = []
        lines.append("Hi,")
        lines.append("Please order the following:")

        // Flavours
        for f in flavours {
            let id = itemID(prefix: "flavour", name: f.name)
            if selectedItemIDs.contains(id) {
                lines.append("* \(f.name) icecream")
            }
        }

        // Formats
        for fmt in formats {
            let id = itemID(prefix: "format", name: fmt.name)
            if selectedItemIDs.contains(id) {
                lines.append("* \(fmt.name)")
            }
        }

        // Extras
        for e in extras {
            let id = itemID(prefix: "extra", name: e.name)
            if selectedItemIDs.contains(id) {
                lines.append("* \(e.name)")
            }
        }

        lines.append(signature)
        return lines.joined(separator: "\n")
    }
}
