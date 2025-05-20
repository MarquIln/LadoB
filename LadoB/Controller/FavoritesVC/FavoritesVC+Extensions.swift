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
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedAlbums["F"]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesRowCell.identifier, for: indexPath) as? FavoritesRowCell
        else {
            return UITableViewCell()
        }

        if let pair = groupedAlbums["F"]?[indexPath.row] {
            cell.config(albums: pair)
        }

        return cell
    }
}

extension FavoritesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        if !query.isEmpty {
            filteredAlbums = favoriteAlbums.filter {
                $0.title.lowercased().contains(query.lowercased()) ||
                $0.artist.lowercased().contains(query.lowercased())
            }

            let sorted = filteredAlbums.sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }

            let paired = stride(from: 0, to: sorted.count, by: 2).map {
                Array(sorted[$0..<min($0 + 2, sorted.count)])
            }

            groupedAlbums = ["F": paired]
            sectionTitles = ["F"]
        } else {
            let sorted = favoriteAlbums.sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }

            let paired = stride(from: 0, to: sorted.count, by: 2).map {
                Array(sorted[$0..<min($0 + 2, sorted.count)])
            }

            groupedAlbums = ["F": paired]
            sectionTitles = ["F"]
        }

        tableView.reloadData()
    }
}

extension FavoritesVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
