//
//  SearchResultsVC.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 19/05/25.
//

import UIKit

class SearchResultsVC: UIViewController {
    
    var filteredData: [Album] = []
    var allResults: [Album] = []
    var searchText: String = ""
    var activeFilter: String = "Todos"
    var sortOption: String = "A-Z"
    
    lazy var collectionView: UICollectionView = {
        let layout = createResultsLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.backgroundColor = .purple1
        return cv
    }()
    
    func updateResults(with results: [Album]) {
        allResults = results
        applyFilters()
    }
    
    func applyFilters() {
        var data = allResults

        switch activeFilter {
        case "Artistas":
            if !searchText.isEmpty {
                data = data.filter {
                    $0.artist.lowercased().hasPrefix(searchText)
                }
            }
        case "Álbuns":
            if !searchText.isEmpty {
                data = data.filter {
                    $0.title.lowercased().hasPrefix(searchText)
                }
            }
        case "Gênero":
            if !searchText.isEmpty {
                data = data.filter {
                    $0.genre.rawValue.lowercased().hasPrefix(searchText)
                }
            }
        default:
            break
        }

        switch sortOption {
        case "A-Z":
            data.sort { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        case "Z-A":
            data.sort { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedDescending }
        case "Ano":
            data.sort { $0.decade > $1.decade }
        default:
            break
        }

        filteredData = data
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        collectionView.register(SearchResultsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultsHeaderView.identifier)
        
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: SearchResultsCell.identifier)
        collectionView.dataSource = self
        
    }
}
