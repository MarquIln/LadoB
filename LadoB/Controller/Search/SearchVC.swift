//
//  SearchVC.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 15/05/25.
//

import UIKit

class SearchVC: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = createAllLayout()
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .purple1
        
        //Cells
        collectionView.register(SmallItemCVCell.self, forCellWithReuseIdentifier: SmallItemCVCell.identifier)
//        collectionView.register(LargeItemCollectionViewCell.self, forCellWithReuseIdentifier: LargeItemCollectionViewCell.identifier)

        // Header
        collectionView.register(SearchSectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SearchSectionHeader.identifier)

        collectionView.dataSource = self

        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        setup()
    }
}
