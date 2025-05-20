//
//  FavoritesVC.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

class FavoritesVC: UIViewController {
    var albums = JSONLoader.loadAlbums(from: "mockedData")
    var favoriteAlbums: [Album] = []
    var filteredAlbums: [Album] = []
    var sectionTitles: [String] = []
    var groupedAlbums: [String: [[Album]]] = [:]

    private let searchController = UISearchController(searchResultsController: nil)

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .purple2
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(FavoritesRowCell.self, forCellReuseIdentifier: FavoritesRowCell.identifier)
        return tableView
    }()

    lazy var emptyFavoritesList: EmptyState = {
        var empty = EmptyState()
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.titleText = "Nenhum LP nos seus favoritos ainda"
        empty.descriptionText = """
        Procure um álbum que gostaria de ter em sua Discoteca, salve nos Favoritos para conseguir ver aqui.
        """
        empty.buttonAction = { [weak self] in
            self?.tabBarController?.selectedIndex = 0
        }
        return empty
    }()

    lazy var actionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(addTapped))
        button.tintColor = .yellow1
        return button
    }()

    lazy var changeVisibilityButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.stack.fill"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(changeVisibilityTapped))
        button.tintColor = .yellow1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple1
        navigationItem.title = "Favoritos"
        navigationController?.navigationBar.backgroundColor = .purple1
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [actionButton, changeVisibilityButton]

        configureSearchController()

        albums.indices.forEach {
            if [8, 80, 33, 25, 7].contains($0) {
                albums[$0].isFavorite = true
            }
        }

        favoriteAlbums = albums.filter { $0.isFavorite == true }

        let sorted = favoriteAlbums.sorted {
            $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
        }

        let paired = stride(from: 0, to: sorted.count, by: 2).map {
            Array(sorted[$0..<min($0 + 2, sorted.count)])
        }

        groupedAlbums = ["F": paired]
        sectionTitles = ["F"]

        setup()
    }

    @objc func addTapped() {
        print("func addTapped")
    }

    @objc func changeVisibilityTapped() {
        print("func changeVisibilityTapped")
    }

    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Álbum, Artista, Banda"
        searchController.searchBar.searchTextField.font = Fonts.bodyBold
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
}
