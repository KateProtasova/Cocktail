//
//  CocktailsRequest.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 16.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

class CocktailsRequest: APIRequest {
    var method = RequestType.GET
    var path = "search.php"
    var parameters = [String: String]()

    init(searchText: String, page: String? = nil) {
        parameters["s"] = searchText
    }

    init(parameters: [String: String]? = nil) {
        self.parameters = parameters ?? [:]
    }
}

