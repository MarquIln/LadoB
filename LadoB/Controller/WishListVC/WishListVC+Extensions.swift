//
//  WishListVC+Extensions.swift
//  LadoB
//

import UIKit

// MARK: - ViewCodeProtocol
extension WishListVC: ViewCodeProtocol {
    func addSubviews() {
        if wishedAlbuns.isEmpty {
            view.addSubview(emptyStateWishList)
        } else {
            view.addSubview(wishListCollectionView)
        }
    }

    func setupConstraints() {
        if wishedAlbuns.isEmpty {
            NSLayoutConstraint.activate([
                emptyStateWishList.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyStateWishList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                emptyStateWishList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        } else {
            NSLayoutConstraint.activate([
                wishListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                wishListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                wishListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                wishListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WishListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive && !filteredAlbums.isEmpty {
            return filteredAlbums.count
        } else {
            return wishedAlbuns.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardWishList.identifier,
            for: indexPath
        ) as? CardWishList else {
            fatalError()
        }

        let album = (searchController.isActive && !filteredAlbums.isEmpty)
            ? filteredAlbums[indexPath.row]
            : wishedAlbuns[indexPath.row]

        if let image = UIImage(named: album.coverAsset) {
            cell.config(imageURL: image, artistName: album.artist, albumName: album.title)
        }

        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension WishListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        if !query.isEmpty {
            filteredAlbums = wishedAlbuns.filter {
                $0.title.lowercased().contains(query.lowercased()) ||
                $0.artist.lowercased().contains(query.lowercased())
            }
        } else {
            filteredAlbums = []
        }

        wishListCollectionView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension WishListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
