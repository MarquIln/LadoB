//
//  SearchVC.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 15/05/25.
//

import UIKit

enum SearchSection: Int, CaseIterable {
    case lastSearched
    case recentlyAdded
    case ladoBIconico
    case highlights
    case classics
    case eighties

    var title: String {
        switch self {
        case .lastSearched: return "Últimas buscas"
        case .recentlyAdded: return "Adicionados recentemente"
        case .ladoBIconico: return "Lado B Icônico"
        case .highlights: return "Destaques"
        case .classics: return "Classicos Atemporais"
        case .eighties: return "Anos 80"
        }
    }

    var jsonFileName: String {
        switch self {
        case .lastSearched: return "lastSearched"
        case .recentlyAdded: return "recentlyAdded"
        case .ladoBIconico: return "ladoBIconico"
        case .highlights: return "highlights"
        case .classics: return "classics"
        case .eighties: return "eighties"
        }
    }
}

class SearchVC: UIViewController {
    var filteredData: [Album] = []

    var isFiltering: Bool {
        return searchController?.isActive ?? false
        && !(searchController?.searchBar.text?.isEmpty ?? true)
    }

    lazy var collectionView: UICollectionView = {
        let layout = createAllLayout()

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .purple1

        //Cells
        collectionView.register(
            SmallCardCVCell.self,
            forCellWithReuseIdentifier: SmallCardCVCell.identifier
        )
        collectionView.register(
            LargeCardCVCell.self,
            forCellWithReuseIdentifier: LargeCardCVCell.identifier
        )

        // Header
        collectionView.register(
            SearchSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView
                .elementKindSectionHeader,
            withReuseIdentifier: SearchSectionHeader.identifier
        )

        collectionView.dataSource = self

        return collectionView
    }()

    var albums: [Album] = []
    var dataBySection: [SearchSection: [Album]] = [:]

    func loadAllSections() {
        SearchSection.allCases.forEach { section in
            if let data = loadJSON(named: section.jsonFileName) {
                dataBySection[section] = data
            }
        }
        collectionView.reloadData()
    }

    func loadJSON(named filename: String) -> [Album]? {
        guard
            let url = Bundle.main.url(
                forResource: filename,
                withExtension: "json"
            )
        else {
            print("File not found: \(filename).json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Album].self, from: data)
        } catch {
            print("Error decoding: \(filename): \(error)")
            return nil
        }
    }

    private var searchResultsVC: SearchResultsVC?
    private var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple2
        loadAllSections()

        navigationItem.title = "Descobrir"
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.hidesSearchBarWhenScrolling = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance


        configureSearchController()
        navigationItem.searchController = searchController

        setup()
    }
    
    private func configureSearchController() {
        
        let resultsVC = SearchResultsVC()
        let controller = UISearchController(searchResultsController: resultsVC)
        
        controller.searchResultsUpdater = self
        controller.searchBar.placeholder = "Álbum, Artista, Banda, Gênero"
        controller.searchBar.searchTextField.font = Fonts.text
        controller.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.autocapitalizationType = .none
        controller.searchBar.setValue(UIColor.yellow1, forKey: "tintColor")
        controller.searchBar.searchTextField.tintColor = .yellow1
        controller.searchBar.searchTextField.textColor = .pink2
        controller.searchBar.delegate = self
        searchResultsVC = resultsVC
        searchController = controller
        navigationItem.searchController = controller
        definesPresentationContext = true
    }
}
