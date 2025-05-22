//
//  FavoritesVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionKey = alphabeticalSections[indexPath.section]
            guard let albumPair = groupedFavoritesByLetter[sectionKey]?[indexPath.row] else {
                return
            }

            // Pega o ponto do clique
            let touchPoint = tableView.panGestureRecognizer.location(in: tableView)

            // Recupera a célula visível tocada
            guard let cell = tableView.cellForRow(at: indexPath) else { return }

            // Verifica o ponto tocado dentro da célula
            let locationInCell = cell.convert(touchPoint, from: tableView)

            // Se clicou na metade esquerda ou direita da célula
            let clickedAlbum: Album
            if locationInCell.x < cell.bounds.width / 2 {
                clickedAlbum = albumPair.first!
            } else {
                // Garante que existe segundo álbum
                clickedAlbum = albumPair.count > 1 ? albumPair[1] : albumPair.first!
            }

            let modal = AlbumModalViewController()
            modal.album = clickedAlbum
            present(modal, animated: true)
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
