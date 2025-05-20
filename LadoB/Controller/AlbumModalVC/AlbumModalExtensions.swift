//
//  AlbumModalExtensions.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 19/05/25.
//
import UIKit

extension AlbumModalViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 4 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 2:
            return 1
        case 1:
            return 3
        case 3:
            return discography.count
        default:
            return 0
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        guard let album = album else { fatalError("Album não setado") }

        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCVCell.identifier, for: indexPath) as! AlbumCVCell
            cell.config(with: album)
            return cell

        case 1:
            print("Seção 1 - item \(indexPath.item)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsModalCVCell.identifier, for: indexPath) as! ButtonsModalCVCell
            switch indexPath.item {
            case 0: cell.config(title: "Tenho", iconButtonimage: "checkmark.circle.fill")
            case 1: cell.config(title: "Favorito", iconButtonimage: "heart.fill")
            case 2: cell.config(title: "No Radar", iconButtonimage: "plus.circle.fill")
            default: break
            }
            return cell

        case 2:
            print("Seção 2 - item \(indexPath.item)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BiographyCVCell.identifier, for: indexPath) as! BiographyCVCell
            cell.config(with: album, biography: album.biography)
            print("📝 Biografia recebida:", album.biography ?? "vazia")
            return cell

        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DiscographyCVCell.identifier,
                for: indexPath
            ) as! DiscographyCVCell

            let item = discography[indexPath.item]
            let img = UIImage(named: item.coverAsset)
            cell.config(with: item, title: item.title, artist: item.artist, image: img)
            return cell


        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        if indexPath.section == 3 {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier,
                for: indexPath
            ) as! SectionHeaderView
            header.setTitle("Discografia")
            return header
        }

        return UICollectionReusableView()
    }
}
