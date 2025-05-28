//
//  DiscoVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 16/05/25.
//

import UIKit

extension DiscoVC: ViewCodeProtocol {
    func addSubviews() {
        navigationItem.title = "Discoteca"
        navigationItem.rightBarButtonItem = addButton
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        view.addSubview(emptyState)
        view.backgroundColor = .purple1
        view.addSubview(tableView)
        
        configureSearchController()
        configureLayout()
        configureTableView()
        loadAlbums()

        allAlbums = JSONLoader.loadAlbums(from: "mockedData")
    }

    func setupConstraints() {}
}

extension DiscoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        emptyState.isHidden = !sectionTitles.isEmpty
        tableView.isHidden = sectionTitles.isEmpty
        return sectionTitles.count
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let album = Persistence.getDiscoAlbuns()[indexPath.section]
//        if isFiltering {
//            album = filteredData[indexPath.item]
//        } else {
//            guard let sectionEnum = SearchSection(rawValue: indexPath.section),
//                  let item = dataBySection[sectionEnum]?[indexPath.item]
//            else { return }
//            album = item
//        }

        let modal = AlbumModalViewController()
        modal.album = album
        present(modal, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        return groupedAlbums[key]?.count ?? 0
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = .yellow1
        tableView.sectionIndexBackgroundColor = .purple2
        
        return sectionTitles
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
            updateAlbums(discoAlbuns)
            return
        }

        let filtered = discoAlbuns.filter {
            $0.title.lowercased().hasPrefix(text) || $0.artist.lowercased().hasPrefix(text)
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
