//
//  SearchDrinksViewModel.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 16.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
import RxSwift


class SearchDrinksViewModel {
    private let disposeBag = DisposeBag()
    private let networkManager = NetworkManager(apiClient: APIClient())
    let searchText = PublishSubject<String>()
    var result: BehaviorSubject<[Cocktail]> = BehaviorSubject(value: [])

       init() {
           fetchedCocktails()
       }

       func fetchedCocktails() {
           self.searchText
               .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
               .distinctUntilChanged()
               .flatMapLatest { searchText -> Observable<[Cocktail]> in
                   if searchText.isEmpty {
                       return .just([])
                   } else {
                    let networkData: Observable<[Cocktail]> = self.networkManager.searchCocktails(text: searchText)
                       return networkData
                   }
           }
           .subscribe(onNext: { chars in
               self.result.on(.next(chars))
           }).disposed(by: disposeBag)
       }
}
