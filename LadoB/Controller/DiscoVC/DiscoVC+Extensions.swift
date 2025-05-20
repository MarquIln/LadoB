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
        view.backgroundColor = .purple1
        view.addSubview(tableView)
        
        configureNavigationBar()
        configureSearchController()
        configureLayout()
        configureTableView()
        loadAlbums()

        allAlbums = JSONLoader.loadAlbums(from: "mockedData")
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
            
            emptyState.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
        ])
    }
}

extension DiscoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        return groupedAlbums[key]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, sectionIndexTitlesForTableView tableView2: UITableView) -> [String]? {
        return sectionTitles
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.reuseIdentifier, for: indexPath) as? CardTableViewCell else {
            return UITableViewCell()
        }

        let key = sectionTitles[indexPath.section]
        if let album = groupedAlbums[key]?[indexPath.row] {
            cell.config(with: album)
        }

        return cell
    }
}

extension DiscoVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased(), !text.isEmpty else {
            updateAlbums(allAlbums)
            return
        }

        let filtered = allAlbums.filter {
            $0.title.lowercased().contains(text) || $0.artist.lowercased().contains(text)
        }

        updateAlbums(filtered)
    }
}

extension DiscoVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateAlbums(allAlbums)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
