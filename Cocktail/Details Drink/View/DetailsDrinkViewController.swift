//
//  DetailsDrinkViewController.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 23.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit

class DetailsDrinkViewController: UIViewController, Storyboarded {

    weak var coordinator: DetailsDrinkCoordinator?
    var cocktail: Cocktail?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(cocktail?.strDrink)


    }
    
}
