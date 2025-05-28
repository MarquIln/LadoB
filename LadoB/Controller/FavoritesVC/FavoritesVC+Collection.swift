//
//  FavoritesVC+Extensions.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

extension FavoritesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsForCoverFlow.count
    }
}

extension FavoritesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albumsForCoverFlow[indexPath.item]

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CoverFlowCell.identifier,
            for: indexPath
        ) as! CoverFlowCell

        cell.configure(with: album)
        return cell
    }
}
