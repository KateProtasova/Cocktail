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

class SearchDrinksViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: SearchDrinksViewModel!
    private let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SearchDrinksViewModel()

        setupTableView()
        setupSearchBar()

        bindSearchBar()
        bindTableView()
    }

    // MARK: - Binding

    func bindTableView() {
        viewModel.result
            .bind(to: tableView.rx.items(cellIdentifier: "CocktailTableViewCell", cellType: CocktailTableViewCell.self)) {(index, cocktail: Cocktail, cell) in
                cell.viewModel = CocktailViewModel(cocktail:cocktail)
        }
        .disposed(by: disposeBag)
        tableView.rx.modelSelected(Cocktail.self)
                   .subscribe(onNext:  { value in
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
