//
//  WishListVC.swift
//  LadoB
//
//  Created by Vítor Bruno on 14/05/25.
//

import UIKit

class WishListVC: UIViewController {
    var albuns = JSONLoader.loadAlbums(from: "mockedData")
    var wishedAlbuns: [Album] = []
    
    lazy var emptyStateWishList: EmptyState = {
            var empty = EmptyState()
            empty.translatesAutoresizingMaskIntoConstraints = false
            empty.titleText = "Nenhum LP cadastrado ainda"
            empty.descriptionText = """
                                    Procure um álbum que gostaria de ter em sua Discoteca, salve no Radar para lembrar na hora que estiver garimpando por aí.
                                    """
            return empty
        }()
    
//    lazy var cardTest: CardWishList = {
//        var card = CardWishList()
//        card.translatesAutoresizingMaskIntoConstraints = false
//        card.artistName = "Teste"
//        card.songName = "Musica banger"
//        card.albumImageURL = URL(string: albuns[0].coverURL) //pega a url do primeiro album
//
//        card.setup()
//        return card
//    }()

    lazy var wishListcollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createSectionLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .purple1
        collectionView.register(CardWishList.self, forCellWithReuseIdentifier: CardWishList.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        
//        albuns[0].isWished = true
//        albuns[4].isWished = true
//        
//        wishedAlbuns = albuns.filter({$0.isWished})
        print(wishedAlbuns)
        
        setup()
    }

}

//MARK: extensao viewcode Protocol
extension WishListVC: ViewCodeProtocol {
    func addSubviews() {
        
        if wishedAlbuns.isEmpty{
            view.addSubview(emptyStateWishList)
        } else{
            view.addSubview(wishListcollectionView)
        }
        
    }
    
    func setupConstraints() {
        
        if wishedAlbuns.isEmpty{
            
            NSLayoutConstraint.activate([
                emptyStateWishList.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyStateWishList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                emptyStateWishList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
            ])
            
        } else{
            NSLayoutConstraint.activate([
                    wishListcollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                    wishListcollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    wishListcollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    wishListcollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    
                ])
        }
        
    }
    
    
}

//MARK: extensao layout UICollectionView

extension WishListVC {
    
    //pra fazer o estilo da secao
    func createSectionLayout() -> UICollectionViewCompositionalLayout {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //grupo
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(217))
    
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = .fixed(22)
        
        //secao
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        section.interGroupSpacing = 4.0
                                                        
        //layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension WishListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishedAlbuns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CardWishList.identifier, for: indexPath) as? CardWishList else {fatalError()}
        
        let album = wishedAlbuns[indexPath.row]
        
        
        if let image = UIImage(named: album.coverAsset) {
            cell.config(imageURL: image, artistName: album.artist, albumName: album.title)
        }

        return cell
    }
    
    
}
