//
//  MainCoordinator.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 23.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator,UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = SearchDrinksViewController.instantiate()
        vc.coordinator = self
        navigationController.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }


    func detailsDrinkSubscription(drink: Cocktail) {
        let child = DetailsDrinkCoordinator(navigationController: navigationController)
        child.cocktail = drink
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let detailsDrinkViewController = fromViewController as? DetailsDrinkViewController {
               childDidFinish(detailsDrinkViewController.coordinator)
        }
    }
}

