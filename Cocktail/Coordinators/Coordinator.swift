//
//  Coordinator.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 23.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

