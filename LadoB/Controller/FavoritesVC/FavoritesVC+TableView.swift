//
//  FavoritesVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoritesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return alphabeticalSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = alphabeticalSections[section]
        return groupedFavoritesByLetter[sectionKey]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FavoritesRowCell.identifier,
                for: indexPath
            ) as? FavoritesRowCell
        else {
            return UITableViewCell()
        }

        let sectionKey = alphabeticalSections[indexPath.section]
        if let albumPair = groupedFavoritesByLetter[sectionKey]?[indexPath.row] {
            cell.config(albums: albumPair)
        }

        return cell
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = .yellow1
        tableView.sectionIndexBackgroundColor = .purple2
        return alphabeticalSections
    }
}
