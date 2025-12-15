//
//  flavourstockview.swift
//  IceCream
//
//  Created by gadje on 12/12/2025.
//

import Foundation
import SwiftUI
import MessageUI

struct FlavourStockView: View {
    @Binding var flavour: Flavour
    
    @StateObject private var flavourRepo = Injector.flavourRepository
    @StateObject private var formatRepo  = Injector.formatRepository
    @StateObject private var extraRepo   = Injector.extraRepository
    
    @StateObject private var stockService = FlavourStockService()
    @StateObject private var sendMailService = Injector.sendMailService
    
    @State private var showMail = false
    @State private var mailTo = ""
    @State private var mailSubject = ""
    @State private var mailBody = ""
    @State private var showMailError = false

    
    var body: some View {
        VStack(spacing: 16) {
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

                    if MFMailComposeViewController.canSendMail() {
                        mailTo = "order@icecream.com"
                        mailSubject = "Order"
                        mailBody = text
                        showMail = true
                    } else {
                        showMailError = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .disabled(stockService.showAllItems)
                .opacity(stockService.showAllItems ? 0.4 : 1.0)
            }
            
            // Check all items / Collapse other items
            Button(stockService.showAllItems ? "Check all items" : "Check all items") {
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
                        let isSelected = stockService.selectedItemIDs.contains(id)
                        let locked = (f.name == flavour.name)
                        
                        HStack(spacing: 10) {
                            Button {
                                guard !locked else { return }
                                if isSelected {
                                    stockService.selectedItemIDs.remove(id)
                                } else {
                                    stockService.selectedItemIDs.insert(id)
                                }
                            } label: {
                                Image(systemName: isSelected
                                      ? "checkmark.square.fill"
                                      : "square")
                                .font(.title3)
                                .opacity(locked ? 0.4 : 1)
                            }
                            .buttonStyle(.plain)
                            .disabled(locked)
                            
                            Text(f.name)
                                .fontWeight(locked ? .semibold : .regular)
                            
                            Spacer()
                            
                            Text("\(f.stock) ml")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    
                    ForEach(formatRepo.formats) { format in
                        let id = stockService.itemID(prefix: "format", name: format.name)
                        let isSelected = stockService.selectedItemIDs.contains(id)
                        
                        HStack(spacing: 10) {
                            Button {
                                if isSelected {
                                    stockService.selectedItemIDs.remove(id)
                                } else {
                                    stockService.selectedItemIDs.insert(id)
                                }
                            } label: {
                                Image(systemName: isSelected
                                      ? "checkmark.square.fill"
                                      : "square")
                                .font(.title3)
                            }
                            .buttonStyle(.plain)
                            
                            Text(format.name)
                            
                            Spacer()
                            
                            Text("\(format.stock)")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    
                    // Extras
                    ForEach(extraRepo.extras) { extra in
                        let id = stockService.itemID(prefix: "extra", name: extra.name)
                        let isSelected = stockService.selectedItemIDs.contains(id)
                        
                        HStack(spacing: 10) {
                            Button {
                                if isSelected {
                                    stockService.selectedItemIDs.remove(id)
                                } else {
                                    stockService.selectedItemIDs.insert(id)
                                }
                            } label: {
                                Image(systemName: isSelected
                                      ? "checkmark.square.fill"
                                      : "square")
                                .font(.title3)
                            }
                            .buttonStyle(.plain)
                            
                            Text(extra.name)
                            
                            Spacer()
                            
                            Text("\(extra.stock) \(extra.unite)")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Order en bas
                    HStack {
                        Spacer()
                        Button("Order") {
                            let text = stockService.orderTextForSelectedItems(
                                flavours: flavourRepo.flavours,
                                formats: formatRepo.formats,
                                extras: extraRepo.extras
                            )
                            stockService.openGeneratedText(text)
                            if MFMailComposeViewController.canSendMail() {
                                mailBody = text
                                showMail = true
                            } else {
                                showMailError = true
                            }
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.purple)
                        
                        Spacer()
                    }
                    .padding(.top, 12)
                }
            }
        }
        .padding(.horizontal,10)
        .padding(.top, 12)
    }
        
}
