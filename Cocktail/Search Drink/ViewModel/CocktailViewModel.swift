//
//  CocktailViewModel.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 16.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

class CocktailViewModel {
    let name: String
    
    init(cocktail: Cocktail) {
        self.name = cocktail.strDrink
    }
}

