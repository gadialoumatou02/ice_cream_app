//
//  icecreamview.swift
//  IceCream
//
//  Created by gadje on 08/12/2025.
//

import SwiftUI

struct FlavourView: View {
    @Binding  var flavor: Flavour
    var body: some View {
        HStack(spacing:16) {
            Image(flavor.image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text(flavor.name)
            
            Spacer()
            HStack(spacing:4){
                Button("-"){
                    flavor.qty -= 1
                }
                .buttonStyle(.bordered)
                .disabled(flavor.qty <= 0)
                Button("+"){
                    flavor.qty += 1
                }
                .buttonStyle(.bordered)
            }
            Spacer()
            
            if flavor.stock == 0 {
                            NavigationLink {
                                FlavourStockView(flavour:$flavor)
                            } label: {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title3)
                                    .frame(width: 40)
                            }
                            .buttonStyle(.plain)
                            .frame(width: 36, alignment: .trailing)
                        } else {
                            Text("\(flavor.qty)")
                                .frame(width: 36, alignment: .trailing)
                        }
            
        }
        .padding(.vertical, 4)
    }
}
/*Preview(traits: .sizeThatFitsLayout) {
    struct PreviewWrapper: View {
        @State private var flavour = Flavour(image: "chocolate", name: "Chocolate", qty: 1)

        var body: some View {
            FlavourView(flavor: $flavour)
                .padding()
        }
    }
    return PreviewWrapper()
}*/
