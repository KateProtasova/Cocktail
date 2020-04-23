//
//  CocktailTableViewCell.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 16.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    var viewModel: CocktailViewModel! {
        didSet {
            self.configure()
        }
    }

    func configure() {
        titleLabel.text = viewModel.name
    }
    
}
