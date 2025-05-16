//
//  SearchExtensions.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 15/05/25.
//

import UIKit

//extension UISearchController {
//    static func create(localizedPlaceholder placeholder: String = "Search") -> UISearchController {
//        let searchController = UISearchController()
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.searchBar.placeholder = placeholder
//        return searchController
//    }
//}

extension SearchVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SearchSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionEnum = SearchSection(rawValue: section),
                 let items = dataBySection[sectionEnum] else {
               return 0
           }
           return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionEnum = SearchSection(rawValue: indexPath.section),
                  let album = dataBySection[sectionEnum]?[indexPath.item] else {
                fatalError("Data not found")
            }
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCardCVCell.identifier, for: indexPath) as? SmallCardCVCell
            else { fatalError() }
            
            let image = UIImage(named: album.coverAsset)
            let title = album.title
            let artist = album.artist

            cell.config(with: album, title: title, artist: artist, image: image, bgColor: .purple1)
                        
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCardCVCell.identifier, for: indexPath) as? LargeCardCVCell
            else { fatalError() }
            
            let image = UIImage(named: album.coverAsset)
            let title = album.title
            let artist = album.artist
            
            cell.config(with: album, title: title, artist: artist, image: image, bgColor: .purple1)
                        
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
        ) as? SearchSectionHeader, let sectionEnum = SearchSection(rawValue: indexPath.section) else {
            fatalError()
        }
        
        header.setTitle(sectionEnum.title)

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
