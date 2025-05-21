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
                bgColor: .purple1
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
                bgColor: .purple1
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

extension SearchResultsVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
}

extension SearchResultsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultsCell.identifier,
            for: indexPath
        ) as? SearchResultsCell else {
            fatalError()
        }

        let album = filteredData[indexPath.item]
        
        cell.config(albumCover: UIImage(named: album.coverAsset), artistName: album.artist, albumName: album.title)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchResultsHeaderView.identifier,
                for: indexPath
            ) as? SearchResultsHeaderView else {
                return UICollectionReusableView()
            }

            header.delegate = self
            return header
        }

        return UICollectionReusableView()
    }
}

extension SearchResultsVC: SearchResultsHeaderViewDelegate {
    
    func didSelectFilter(_ filter: String) {
        print("Filtro selecionado: \(filter)")

        switch filter {
            case "Artistas":
                filteredData = allResults.filter { !$0.artist.isEmpty }

            case "Álbuns":
                filteredData = allResults.filter { !$0.title.isEmpty }

            case "Gênero":
                filteredData = allResults.filter { $0.genre.rawValue.isEmpty == false }
            default:
                filteredData = allResults
            }

          collectionView.reloadData()
    }

    func didSelectSortOption(_ sortOption: String) {
        // Ordena os dados com base no critério
        print("Ordenar por: \(sortOption)")
        
        switch sortOption {
        case "A–Z":
            filteredData.sort { (a: Album, b: Album) in
                a.title.localizedCaseInsensitiveCompare(b.title) == .orderedAscending
            }
        case "Z–A":
            filteredData.sort { (a: Album, b: Album) in
                a.title.localizedCaseInsensitiveCompare(b.title) == .orderedDescending
            }
        case "Ano":
            filteredData.sort { (a: Album, b: Album) in
                (a.decade) > (b.decade)
            }
        default:
            break
        }

        collectionView.reloadData()
    }
}



extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty, let resultsVC = searchController.searchResultsController as? SearchResultsVC else {
            filteredData = []
            collectionView.reloadData()
            return
        }

        let allAlbums = dataBySection.flatMap { $0.value }

        let uniqueAlbums = Dictionary(grouping: allAlbums, by: { "\($0.title.lowercased())-\($0.artist.lowercased())" })
            .compactMap { $0.value.first }

        filteredData = uniqueAlbums.filter {
            $0.title.lowercased().hasPrefix(searchText)
        }
        .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        
        resultsVC.updateResults(with: filteredData)

        collectionView.reloadData()
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
