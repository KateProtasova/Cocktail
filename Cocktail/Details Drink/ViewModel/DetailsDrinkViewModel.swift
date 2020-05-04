//
//  DetailsDrinkViewModel.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 29.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire

class  DetailsDrinkViewModel {
    var title: BehaviorSubject<String>
    let instructions: BehaviorSubject<String>

    private let imageStr:String
    private let networkManager = NetworkManager(apiClient: APIClient())

    init(cocktail: Cocktail) {
        self.title = BehaviorSubject(value: cocktail.strDrink)
        self.instructions = BehaviorSubject(value: cocktail.strInstructions)
        self.imageStr =  cocktail.strDrinkThumb
    }

    func showImage() -> Observable<UIImage?> {
        return networkManager.showImageForUrl(url: imageStr)
    }
}

