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
    
    func groupAlbumsByInitialsAndPairs(from albums: [Album]) {
        let sorted = albums.sorted {
            $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
        }

        let pairs = stride(from: 0, to: sorted.count, by: 2).map {
            Array(sorted[$0..<min($0 + 2, sorted.count)])
        }

        var grouped: [String: [[Album]]] = [:]
        var letters: Set<String> = []

        for pair in pairs {
            if let first = pair.first {
                let firstLetter = String(first.title.prefix(1)).uppercased()
                grouped[firstLetter, default: []].append(pair)
                letters.insert(firstLetter)
            }

            if pair.count == 2 {
                let second = pair[1]
                let secondLetter = String(second.title.prefix(1)).uppercased()
                letters.insert(secondLetter)
            }
        }

        groupedAlbums = grouped
        sectionTitles = letters.sorted()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple1
        navigationItem.title = "Favoritos"
        navigationController?.navigationBar.backgroundColor = .purple1
        navigationController?.navigationBar.tintColor = UIColor.yellow1
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.pink2]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [actionButton, changeVisibilityButton]

        configureSearchController()

        albums.indices.forEach {
            if [7, 8, 80, 33, 25, 10, 12].contains($0) {
                albums[$0].isFavorite = true
            }
        }

        favoriteAlbums = albums.filter { $0.isFavorite == true }

        groupAlbumsByInitialsAndPairs(from: favoriteAlbums)

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
