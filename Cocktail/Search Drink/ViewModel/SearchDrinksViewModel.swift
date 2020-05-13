//
//  SearchDrinksViewModel.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 16.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class SearchDrinksViewModel {
    private let disposeBag = DisposeBag()
    private let networkManager = NetworkManager(apiClient: APIClient())
    let searchText = PublishSubject<String>()
    var result: BehaviorSubject<[Cocktail]> = BehaviorSubject(value: [])
    var infoMessage = PublishSubject<String>()

    init() {
        fetchedCocktails()
    }

    func fetchedCocktails() {
        self.searchText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { searchText -> Observable<Event<[Cocktail]>> in
                if searchText.isEmpty {
                    self.infoMessage.onNext("Введите название напитка")
                    return .just(.next([]))
                } else {
                    let networkData: Observable<[Cocktail]> = self.networkManager.searchCocktails(text: searchText)
                    return networkData.materialize()
                }
        }.subscribe(onNext: { networkEvents in
            switch networkEvents {
            case .next(let cocktails):
                print(cocktails)
                self.result.onNext(cocktails)
            case .error(let error):
                self.result.onNext([])
                self.infoMessage.onNext(error.localizedDescription)
            default:
                ()
            }
        }).disposed(by: disposeBag)
    }
}
