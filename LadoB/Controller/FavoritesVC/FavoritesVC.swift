//
//  FavoritesVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

class FavoritesVC: UIViewController {
    var allAlbums = JSONLoader.loadAlbums(from: "mockedData")
    var favorites: [Album] = []
    var filteredFavorites: [Album] = []

    var groupedFavoritesByLetter: [String: [[Album]]] = [:]
    var alphabeticalSections: [String] = []

    var isCoverFlowVisible = false

    var albumsForCoverFlow: [Album] { favorites }
    var currentAlbumTitle: String?

    let searchController = UISearchController(
        searchResultsController: nil
    )

    lazy var favoritesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .purple2
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            FavoritesRowCell.self,
            forCellReuseIdentifier: FavoritesRowCell.identifier
        )
        return tableView
    }()

    lazy var emptyStateView: EmptyState = {
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
    
    lazy var coverFlowView: CoverFlowVC = {
        let coverFlow = CoverFlowVC()
        coverFlow.albums = self.albumsForCoverFlow
        return coverFlow
    }()

    lazy var coverFlowCollectionView: UICollectionView = {
        let layout = StackFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .purple2
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CoverFlowCell.self,
            forCellWithReuseIdentifier: CoverFlowCell.identifier
        )
        
        return collectionView
    }()

    lazy var albumTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.bodyBold
        label.textColor = .pink2
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.bodyBold
        label.textColor = .pink2
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    lazy var albumInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            albumTitleLabel, artistLabel,
        ])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()

    lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.3"),
            style: .plain,
            target: self,
            action: #selector(toggleCoverFlowView)
        )
        button.tintColor = .yellow1
        return button
    }()

    lazy var toggleViewButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(),
            style: .plain,
            target: self,
            action: #selector(toggleCoverFlowView)
        )
        button.tintColor = .yellow1
        return button
    }()
    
    func updateToggleButton() {
        let iconName = isCoverFlowVisible ? "square.grid.2x2" : "square.stack.fill"
        toggleViewButton.image = UIImage(systemName: iconName)
        navigationItem.rightBarButtonItem = toggleViewButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        loadMockFavorites()
//        Persistence.saveToFaves(allAlbums[17])
//        Persistence.saveToFaves(allAlbums[50])
//        Persistence.saveToFaves(allAlbums[35])
//        Persistence.saveToFaves(allAlbums[39])
//        Persistence.saveToFaves(allAlbums[69])
        //Persistence.saveToFaves(allAlbums[41])
        //adicionei duas vezes os mesmo albuns sem querer, mas ta funcionando
        favorites = Persistence.getFaves()
        groupFavoritesByInitialsAndPairs(from: favorites)
        setup()

        updateToggleButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coverFlowCollectionView.setContentOffset(.zero, animated: false)

        if isCoverFlowVisible, let first = albumsForCoverFlow.first {
            updateAlbumLabels(with: first)
        }
    }

    func loadMockFavorites() {
        let mockFavoriteIndices = [7, 8, 80, 33, 25, 10, 12]
        mockFavoriteIndices.forEach { index in
            guard allAlbums.indices.contains(index) else { return }
            allAlbums[index].isFavorite = true
        }
    }

    func groupFavoritesByInitialsAndPairs(from albums: [Album]) {
        let sorted = albums.sorted {
            $0.title.localizedCaseInsensitiveCompare($1.title)
                == .orderedAscending
        }
        let pairs = stride(from: 0, to: sorted.count, by: 2).map {
            Array(sorted[$0..<min($0 + 2, sorted.count)])
        }

        var grouped: [String: [[Album]]] = [:]
        var initials: Set<String> = []

        for pair in pairs {
            if let first = pair.first {
                let firstLetter = String(first.title.prefix(1)).uppercased()
                grouped[firstLetter, default: []].append(pair)
                initials.insert(firstLetter)
            }
            if pair.count == 2 {
                let secondLetter = String(pair[1].title.prefix(1)).uppercased()
                initials.insert(secondLetter)
            }
        }

        groupedFavoritesByLetter = grouped
        alphabeticalSections = initials.sorted()
    }

    func refreshMainView() {
        [
            favoritesTableView, emptyStateView, coverFlowView.view,
            albumInfoStackView
        ].forEach {
            $0.removeFromSuperview()
        }

        addSubviews()
        setupConstraints()

        if isCoverFlowVisible {
            coverFlowView.albums = albumsForCoverFlow
            coverFlowView.pagerView.reloadData()
            if let firstAlbum = albumsForCoverFlow.first {
                updateAlbumLabels(with: firstAlbum)
            }
        } else {
            favoritesTableView.reloadData()
        }
    }
    
    @objc func toggleCoverFlowView() {
        isCoverFlowVisible.toggle()
        refreshMainView()

        let iconName = isCoverFlowVisible ? "square.grid.2x2" : "square.stack.fill"
        toggleViewButton.image = UIImage(systemName: iconName)
    }
}
