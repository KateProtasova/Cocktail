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
    private var params = PublishSubject<[String: String]>()

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func searchCocktails(text: String, page: String? = nil) -> PublishSubject<[Cocktail]> {

        let request = CocktailsRequest(searchText: text, page: page)
        let urlRequest = request.urlRequest(with: self.baseURL)
        let initial: Observable<Drinks> = self.apiClient.send(urlRequest: urlRequest)
        let cocktails = PublishSubject<[Cocktail]>()

        initial.subscribe(onNext: { root in
            cocktails.onNext(root.drinks)
        }, onError: { error in
            cocktails.onError(error)
        }).disposed(by: self.disposeBag)

        return cocktails
    }

    func showImageForUrl(url: String) -> Observable<UIImage?> {
        return RxAlamofire
            .requestData(.get, url)
            .map({ (response,data) -> UIImage? in
                return UIImage(data: data)
            })
    }
}

