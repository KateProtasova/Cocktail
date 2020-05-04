//
//  DetailsDrinkViewController.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 23.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsDrinkViewController: UIViewController, Storyboarded {

    weak var coordinator: DetailsDrinkCoordinator?
    var viewModel: DetailsDrinkViewModel!
    @IBOutlet private var cocktaillImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var instructionsLabel: UILabel!
    private let disposeBag = DisposeBag()

    @IBOutlet var ingredientLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupNavBar()
    }

    func bind() {
        viewModel.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.instructions
            .bind(to: instructionsLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.showImage() .bind(to: cocktaillImageView.rx.image)
            .disposed(by: disposeBag)
    }

    func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
}
