//
//  icecreamservice.swift
//  IceCream
//
//  Created by gadje on 12/12/2025.
//

import Foundation

struct IceCreamService {
    // Nombre total de boule de glace
    func totalboule(_ flavours: [Flavour])-> Int {
        var total = 0
        for flavour in flavours {
            total += flavour.qty
        }
        return total
    }
    
    //Verifier si on peut créer la glace
    func tooManyScoop(_ flavours: [Flavour])-> Bool {
        let total_boule = totalboule(flavours)
        if total_boule == 0 || total_boule > 5 {
            return false
        }
        return true
    }
    
    // Calcule le prix de la glace
    // prix de la boule
    func boulePrix(boule: Int)-> Double {
        
        if boule == 1 {
            return 1.50
        } else if boule == 2 {
            return 3.00
        } else if boule == 3 {
            return 4.00
        } else if boule == 4 {
            return 5.00
        } else if boule == 5 {
            return 5.50
        }
        else {
            return 0.00
        }
    }
    func glacePrix(flavours: [Flavour],
              format: Format,
              extrasSelected: [Extra]
    ) -> Double {
        let nbre_boule = totalboule(flavours)
        let boule_price = boulePrix(boule: nbre_boule)
        let prixFormat  = format.price
        
        var extra_prix = 0.0
        for extra in extrasSelected {
            extra_prix += extra.price
        }
        
        return boule_price + prixFormat + extra_prix
    }
    
    // Affichage du prix
    func formatPrice(_ value: Double) -> String {

            if value == Double(Int(value)) {
                return String(Int(value))
            } else {
                return String(format: "%.2f", value)
            }
        }
    func formatFormatPrice(_ value: Double) -> String {

        if value == 0 {
            return "Free"
        } else {
            return "€ " + formatPrice(value)
        }
    }

}
