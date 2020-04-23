//
//  NetworkManager.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 16.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

import RxSwift
import RxAlamofire

class NetworkManager {

    private let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/")!
    private var apiClient: APIClient
    private let disposeBag = DisposeBag()
    private var cocktails = PublishSubject<[Cocktail]>()

    private var params = PublishSubject<[String: String]>()

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

//    var lastText = ""
//
//    func searchCharacters(text: String, page: String? = nil) -> PublishSubject<[Character]> {
//        lastText = text
//        return searchCocktails(text: text)
//    }

     func searchCocktails(text: String, page: String? = nil) -> PublishSubject<[Cocktail]> {

        let request = CocktailsRequest(searchText: text, page: page)
        let urlRequest = request.urlRequest(with: self.baseURL)
        let initial: Observable<Drinks> = self.apiClient.send(urlRequest: urlRequest)

        initial.subscribe(onNext: { root in
            print(root.drinks)
         self.cocktails.onNext(root.drinks)

        }, onError: { error in
            print("Error")
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Dispose")
        }).disposed(by: self.disposeBag)

        return cocktails
    }
}

