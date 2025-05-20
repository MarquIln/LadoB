//
//  FavoritesVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

extension FavoritesVC: ViewCodeProtocol {
    func addSubviews() {
        if favoriteAlbums.isEmpty {
            view.addSubview(emptyFavoritesList)
        } else {
            view.addSubview(tableView)
        }
    }

    func setupConstraints() {
        if favoriteAlbums.isEmpty {
            NSLayoutConstraint.activate([
                emptyFavoritesList.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyFavoritesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                emptyFavoritesList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoritesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        return groupedAlbums[key]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesRowCell.identifier, for: indexPath) as? FavoritesRowCell
        else {
            return UITableViewCell()
        }

        let key = sectionTitles[indexPath.section]
        
        if let pair = groupedAlbums[key]?[indexPath.row] {
            cell.config(albums: pair)
        }
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = .yellow1
        tableView.sectionIndexBackgroundColor = .purple2
        
        return sectionTitles
    }
}

extension FavoritesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""

        if query.isEmpty {
            groupAlbumsByInitialsAndPairs(from: favoriteAlbums)
        } else {
            let filtered = favoriteAlbums.filter {
                $0.title.lowercased().contains(query.lowercased()) ||
                $0.artist.lowercased().contains(query.lowercased())
            }

            groupAlbumsByInitialsAndPairs(from: filtered)
        }

        tableView.reloadData()
    }
}

extension FavoritesVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
