//
//  DetailsDrinkCoordinator.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 23.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
import UIKit

class DetailsDrinkCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var cocktail: Cocktail?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }



    func start() {
        let vc = DetailsDrinkViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = DetailsDrinkViewModel(cocktail: cocktail!)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
