//
//  DiscoVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 16/05/25.
//

import UIKit

extension DiscoVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(emptyState)
        view.addSubview(cardTableView)

        cardTableView.translatesAutoresizingMaskIntoConstraints = false

        allAlbums = JSONLoader.loadAlbums(from: "mockedData")
        rows = buildRows(from: allAlbums)
        sections = Array(repeating: 0, count: rows.count)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyState.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 321
            ),
            emptyState.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            emptyState.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),

            cardTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
        ])
    }
}

extension DiscoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return rows[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CardTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? CardTableViewCell
        else {
            return UITableViewCell()
        }

        let album: Album = rows[indexPath.section][indexPath.row]
        cell.config(with: album)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        emptyState.isHidden = sections.isEmpty
        cardTableView.isHidden = !sections.isEmpty
        return sections.count
    }
}

extension DiscoVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty else {
            cardTableView.updateAlbums(allAlbums)
            return
        }

        let filtered = allAlbums.filter {
            $0.title.lowercased().contains(searchText) ||
            $0.artist.lowercased().contains(searchText)
        }

        cardTableView.updateAlbums(filtered)
    }
}

extension DiscoVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        rows = buildRows(from: allAlbums)
        sections = Array(repeating: 0, count: rows.count)
        cardTableView.updateAlbums(allAlbums)
    }
}
