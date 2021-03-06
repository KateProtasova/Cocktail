//
//  SearchDrinksViewController.swift
//  Cocktail
//
//  Created by Екатерина Протасова on 16.04.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchDrinksViewController: UIViewController, Storyboarded {
    private let disposeBag = DisposeBag()
    private var viewModel: SearchDrinksViewModel!
    private let searchController = UISearchController(searchResultsController: nil)
    weak var coordinator: MainCoordinator?

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchDrinksViewModel()
        setupTableView()
        setupSearchBar()
        bindSearchBar()
        bindTableView()
        showInfoMessage()
    }

    // MARK: - Binding

    func bindTableView() {
        viewModel.result.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "CocktailTableViewCell", cellType: CocktailTableViewCell.self)) {(index, cocktail: Cocktail, cell) in
                self.infoLabel.isHidden = true
                self.tableView.isHidden = false
                cell.viewModel = CocktailViewModel(cocktail:cocktail)
        }
        .disposed(by: disposeBag)
        tableView.rx.modelSelected(Cocktail.self)
                   .subscribe(onNext:  { value in
                    self.coordinator?.detailsDrinkSubscription(drink: value)
                      print(value)
                   })
                   .disposed(by: disposeBag)

    }

    func bindSearchBar() {
        searchController.searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }

    func showInfoMessage(){
           viewModel.infoMessage.asDriver(onErrorJustReturn: "")
               .drive(onNext: {  errorString in
                   self.infoLabel.isHidden = false
                   self.tableView.isHidden = true
                   self.infoLabel.text = errorString
               })
           .disposed(by: disposeBag)
       }

    // MARK: - UI Setup

    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }

    func setupTableView() {
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "CocktailTableViewCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}
