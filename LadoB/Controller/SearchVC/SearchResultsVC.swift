//
//  SearchResultsVC.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 19/05/25.
//

import UIKit

class SearchResultsVC: UIViewController {
    
    var filteredData: [Album] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = createResultsLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.backgroundColor = .purple1
        return cv
    }()
    
    func updateResults(with results: [Album]) {
        filteredData = results
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: SearchResultsCell.identifier)
        collectionView.dataSource = self
        
    }
}
