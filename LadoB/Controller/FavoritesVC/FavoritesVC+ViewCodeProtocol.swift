//
//  FavoritesVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

extension FavoritesVC: ViewCodeProtocol {
    func addSubviews() {
        view.backgroundColor = .purple1
        navigationItem.title = "Favoritos"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = navigationButtons

        navigationController?.navigationBar.backgroundColor = .purple1
        navigationController?.navigationBar.tintColor = .yellow1
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.pink2
        ]
        
        if favorites.isEmpty {
            view.addSubview(emptyStateView)
            return
        }

        if isCoverFlowVisible {
            view.addSubview(coverFlowCollectionView)
            view.addSubview(albumInfoStackView)
        } else {
            view.addSubview(favoritesTableView)
        }
    }

    func setupConstraints() {
        if favorites.isEmpty {
            NSLayoutConstraint.activate([
                emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        } else if isCoverFlowVisible {
            NSLayoutConstraint.activate([
                coverFlowCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                coverFlowCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                coverFlowCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                coverFlowCollectionView.bottomAnchor.constraint(equalTo: albumInfoStackView.topAnchor),

                albumInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                albumInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                albumInfoStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            ])
        } else {
            NSLayoutConstraint.activate([
                favoritesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }
}
