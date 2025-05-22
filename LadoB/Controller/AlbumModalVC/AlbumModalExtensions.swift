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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsModalCVCell.identifier, for: indexPath) as! ButtonsModalCVCell

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

                guard album.id != nil else {
                    print("álbum sem id válido")
                    return
                }
                print("foi clicado!")

                // Atualiza os valores do álbum
                switch indexPath.item {
                case 0:
                    self.album.isWished?.toggle()
                    if self.album.isWished == true {
                        Persistence.saveToWishlist(self.album)
                    } else {
                        Persistence.removeFromWishlist(self.album)
                    }
                    // Se clicar em "Tenho", desativa "No radar"
                    self.album.isDisco = false
                    Persistence.removeFromDisco(self.album)

                case 1:
                    self.album.isFavorite?.toggle()
                    if self.album.isFavorite == true {
                        Persistence.saveToFaves(self.album)
                    } else {
                        Persistence.removeFromFaves(self.album)
                    }
                    // Se clicar em "Favorito", desativa "No radar"
                    self.album.isDisco = false
                    Persistence.removeFromDisco(self.album)

                case 2:
                    // Ativando "No radar" desativa os outros
                    self.album.isDisco = true
                    self.album.isFavorite = false
                    self.album.isWished = false

                    Persistence.saveToDisco(self.album)
                    Persistence.removeFromFaves(self.album)
                    Persistence.removeFromWishlist(self.album)

                default:
                    break
                }

                self.collectionView.reloadSections(IndexSet(integer: 1))
            }

            // Definir o fundo de acordo com os estados
            if indexPath.item == 0 {
                cell.backgroundColor = album.isWished == true ? UIColor(named: "Yellow1") : .pink1
            } else if indexPath.item == 1 {
                cell.backgroundColor = album.isFavorite == true ? UIColor(named: "Yellow1") : .pink1
            } else if indexPath.item == 2 {
                cell.backgroundColor = album.isDisco == true ? UIColor(named: "Yellow1") : .pink1
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
