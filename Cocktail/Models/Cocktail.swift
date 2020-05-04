//
//  Cocktail.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 16.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

class Drinks: Codable {
   var drinks: [Cocktail] = []
}

class Cocktail: Codable {
    let idDrink: String
    let strDrink: String
    let strInstructions: String
    let strDrinkThumb: String

}
