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
        return isFiltering ? 1 : SearchSection.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if isFiltering {
            return filteredData.count
        }
        guard let sectionEnum = SearchSection(rawValue: section),
              let items = dataBySection[sectionEnum]
        else {
            return 0
        }
        return items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let album: Album
        if isFiltering {
            album = filteredData[indexPath.item]
        } else {
            guard let sectionEnum = SearchSection(rawValue: indexPath.section),
                  let item = dataBySection[sectionEnum]?[indexPath.item]
            else {
                fatalError("Data not found")
            }
            album = item
        }
        
        let useSmallCard = !isFiltering && indexPath.section == 0
        let identifier =
        useSmallCard
        ? SmallCardCVCell.identifier : LargeCardCVCell.identifier
        
        if useSmallCard,
           let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
           ) as? SmallCardCVCell
        {
            cell.config(
                with: album,
                title: album.title,
                artist: album.artist,
                image: UIImage(named: album.coverAsset),
                bgColor: .purple2
            )
            return cell
        } else if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? LargeCardCVCell {
            cell.config(
                with: album,
                title: album.title,
                artist: album.artist,
                image: UIImage(named: album.coverAsset),
                bgColor: .purple2
            )
            return cell
        }
        
        fatalError("Unable to dequeue cell")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SearchSectionHeader.identifier,
            for: indexPath
        )

        if isFiltering {
            header.isHidden = true
            return header
        }

        if let header = header as? SearchSectionHeader,
           let sectionEnum = SearchSection(rawValue: indexPath.section) {
            header.isHidden = false
            header.setTitle(sectionEnum.title)
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
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty else {
            filteredData = []
            collectionView.reloadData()
            return
        }

        let allAlbums = dataBySection.flatMap { $0.value }

        let uniqueAlbums = Dictionary(grouping: allAlbums, by: { "\($0.title.lowercased())-\($0.artist.lowercased())" })
            .compactMap { $0.value.first }

        filteredData = uniqueAlbums.filter {
            $0.title.lowercased().contains(searchText) ||
            $0.artist.lowercased().contains(searchText)
        }

        collectionView.reloadData()
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
