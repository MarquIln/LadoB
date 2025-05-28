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
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ButtonsModalCVCell.identifier,
                for: indexPath
            ) as! ButtonsModalCVCell

            // Configuração visual
            switch indexPath.item {
            case 0:
                cell.config(title: "Tenho", iconButtonimage: "checkmark.circle.fill")
            case 1:
                cell.config(title: "Favorito", iconButtonimage: "heart.fill")
            case 2:
                cell.config(title: "No radar", iconButtonimage: "plus.circle.fill")
            default:
                break
            }

            cell.onTap = { [weak self] in
                guard let self = self else { return }
                //self.collectionView.reloadSections(IndexSet(integer: 1))
                switch indexPath.item {
                case 0: // Tenho
                    self.album.isDisco = !(self.album.isDisco ?? false)
                    if self.album.isDisco == true {
                        Persistence.saveToDisco(self.album)
                    } else {
                        Persistence.removeFromDisco(self.album)
                    }

                case 1: // Favorito
                    self.album.isFavorite = !(self.album.isFavorite ?? false)
                    if self.album.isFavorite == true {
                        Persistence.saveToFaves(self.album)
                    } else {
                        Persistence.removeFromFaves(self.album)
                    }
                   
                case 2: // No Radar
                    let isNowOnRadar = !(self.album.isWished ?? false)
                    self.album.isWished = isNowOnRadar

                    if isNowOnRadar == true {
                        self.album.isDisco = false
                        self.album.isFavorite = false
                        Persistence.removeFromDisco(self.album)
                        Persistence.removeFromFaves(self.album)
                        Persistence.saveToWishlist(self.album)
                    } else if isNowOnRadar == false {
                        self.album.isWished = false
                        Persistence.removeFromWishlist(self.album)
                    }
                   
                default: break
                }

                self.collectionView.reloadSections(IndexSet(integer: 1))
            }

            
            switch indexPath.item {
            case 0:
                cell.setHighlight(isHighlighted: album.isDisco == true)
            case 1:
                cell.setHighlight(isHighlighted: album.isFavorite == true)
            case 2:
                cell.setHighlight(isHighlighted: album.isWished == true)
            default:
                break
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
                withReuseIdentifier: SectionHeaderView2.identifier,
                for: indexPath
            ) as! SectionHeaderView2
            header.setTitle("Discografia")
            return header
        }

        return UICollectionReusableView()
    }
}
