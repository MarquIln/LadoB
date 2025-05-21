//
//  FavoritesVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

extension FavoritesVC {
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Álbum, Artista, Banda"
        searchController.searchBar.searchTextField.font = Fonts.bodyBold
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
}

extension FavoritesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""

        if query.isEmpty {
            groupFavoritesByInitialsAndPairs(from: favorites)
        } else {
            let filtered = favorites.filter {
                $0.title.lowercased().hasPrefix(query.lowercased()) ||
                $0.artist.lowercased().hasPrefix(query.lowercased())
            }

            groupFavoritesByInitialsAndPairs(from: filtered)
        }

        favoritesTableView.reloadData()
    }
}

extension FavoritesVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension FavoritesVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isCoverFlowVisible else { return }

        let centerY = coverFlowCollectionView.bounds.midY + scrollView.contentOffset.y
        let centerPoint = CGPoint(x: coverFlowCollectionView.bounds.midX, y: centerY)

        if let indexPath = coverFlowCollectionView.indexPathForItem(at: centerPoint),
           indexPath.item < albumsForCoverFlow.count {
            let album = albumsForCoverFlow[indexPath.item]
            updateAlbumLabels(with: album)
        }
    }

    func updateAlbumLabels(with album: Album) {
        guard album.title != albumTitleLabel.text else { return }

        UIView.transition(
            with: albumInfoStackView,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: {
                self.albumTitleLabel.text = album.title
                self.artistLabel.text = "\(album.artist) (\(album.decade))"
            },
            completion: nil
        )
    }
}
