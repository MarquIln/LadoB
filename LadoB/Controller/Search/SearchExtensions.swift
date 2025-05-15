//
//  SearchExtensions.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 15/05/25.
//

import UIKit

extension UISearchController {
    static func create(localizedPlaceholder placeholder: String = "Search") -> UISearchController {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = placeholder
        return searchController
    }
}

extension SearchVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCardCVCell.identifier, for: indexPath) as? SmallCardCVCell
            else { fatalError() }
            
            cell.config(title: "Name", artist: "Artist", image: UIImage(named: "Checker"), bgColor: .purple1)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCardCVCell.identifier, for: indexPath) as? LargeCardCVCell
            else { fatalError() }
            
            cell.config(title: "Name", artist: "Artist", image: UIImage(named: "Checker2"), bgColor: .purple1)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SearchSectionHeader.identifier,
            for: indexPath
        ) as? SearchSectionHeader else {
            fatalError()
        }
        
        if indexPath.section == 0 {
            header.setTitle("Últimas pesquisas")
        } else {
            header.setTitle("Adicionados recentemente")
        }

        return header
    }
    
}

extension SearchVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
