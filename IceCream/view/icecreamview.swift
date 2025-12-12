//
//  icecreamview.swift
//  IceCream
//
//  Created by gadje on 12/12/2025.
//

import Foundation
import SwiftUI

struct IceCreamView : View {
    @Binding  var icecream: IceCream
    @StateObject private var repo = Injector.flavourRepository
    let formatrepo = Injector.formatRepository
    let extrarepo = Injector.extraRepository
    let service = IceCreamService()
    
    var body: some View {
        let plusBoule = service.tooManyScoop(repo.flavours)
        let totalBoule = service.totalboule(repo.flavours)
        let price_glace = service.glacePrix(flavours:repo.flavours,
                                                    format: icecream.format, extrasSelected: icecream.extras)
        let scoopmany = totalBoule > 5
        
        VStack {
            HStack(spacing:16){
                Text("Ice cream") .font(.headline)
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary)

            // Flavour
            HStack(spacing:16){
                Text("Scoop flavours") .font(.headline)
                Spacer()
                Text(scoopmany ? "Too many scoops selected" : "Maximum 5")
                    .foregroundColor(scoopmany ? .red : .secondary)
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary)

            List($repo.flavours){ $flavor in
                FlavourView(flavor: $flavor)
            }
            .listStyle(.plain)
            .frame(height: 3 * 72)
            
            // Format
            Text("Cone or Cup")
                    .font(.headline)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(formatrepo.formats, id: \.name) { format in
                    Button {
                        // sélection du format (radio = un seul possible)
                        icecream.format = format
                    } label: {
                        HStack {
                            // Icône radio
                            Image(systemName: icecream.format.name == format.name
                                  ? "largecircle.fill.circle"
                                  : "circle")
                            
                            Text(format.name)
                            
                            Spacer() // pousse le prix à droite
                            
                            Text(service.formatFormatPrice(format.price))
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            
            // Extras
            Text("Extras")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
            VStack(alignment: .leading, spacing: 12) {
                ForEach(extrarepo.extras, id: \.name) { extra in
                    let isSelected = icecream.extras.contains { $0.name == extra.name }
                    
                    Button {
                        if isSelected {
                            // enlever l'extra
                            icecream.extras.removeAll { $0.name == extra.name }
                        } else {
                            // ajouter l'extra
                            icecream.extras.append(extra)
                        }
                    } label: {
                        HStack {
                            // Icône checkbox
                            Image(systemName: isSelected
                                  ? "checkmark.square.fill"
                                  : "square")
                            
                            Text(extra.name)
                            
                            Spacer() // pousse le prix à droite
                            
                            Text("€ \(service.formatPrice(extra.price))")
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            HStack(spacing:16){
                Text("Price") .font(.headline)
                Spacer()
                Text("€")
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary)
            Button("Make icecream"){
                print("Ice cream created")
            }
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            .disabled(!plusBoule)
            .opacity(plusBoule ? 1 : 0.5)
            .padding(.top, 12)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.primary)
        .padding()
    }
}
