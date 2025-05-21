//
//  WishListVC.swift
//  LadoB
//
//  Created by Vítor Bruno on 14/05/25.
//

import UIKit

class WishListVC: UIViewController {
    var albuns = JSONLoader.loadAlbums(from: "mockedData")
    var wishedAlbuns: [Album] = []
    var filteredAlbums: [Album] = []

    lazy var emptyStateWishList: EmptyState = {
        var empty = EmptyState()
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.titleText = "Nenhum LP cadastrado ainda"
        empty.descriptionText = """
        Procure um álbum que gostaria de ter em sua Discoteca, salve no Radar para lembrar na hora que estiver garimpando por aí.
        """
        empty.buttonAction = { [weak self] in
            self?.tabBarController?.selectedIndex = 0
        }
        return empty
    }()

    lazy var wishListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createSectionLayout())
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -6)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .purple2
        collectionView.register(CardWishList.self, forCellWithReuseIdentifier: CardWishList.identifier)
        return collectionView
    }()

    let searchController = UISearchController(searchResultsController: nil)

    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Álbum, Artista, Banda"
        searchController.searchBar.searchTextField.font = Fonts.bodyBold
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        navigationItem.title = "No Radar"
        navigationController?.navigationBar.backgroundColor = .purple1
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]

        configureSearchController()
        
//        Persistence.saveToWishlist(albuns[78])
//        Persistence.saveToWishlist(albuns[66])

        wishedAlbuns = Persistence.getWishedAlbuns()

        setup()
    }
}
