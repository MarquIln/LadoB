//
//  WishListVC.swift
//  LadoB
//
//  Created by Vítor Bruno on 14/05/25.
//

import UIKit

class WishListVC: UIViewController {
    var albuns = Album.loadAlbunsFromJSON() //pegando os albusn do json pra por na tela
    
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
//        card.albumImageURL = URL(string: album[0].coverURL) //pega a url do primeiro album
//
//        card.setup()
//        return card
//    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        
        
        setup()
    }

}

extension WishListVC: ViewCodeProtocol {
    func addSubviews() {
        
        if albuns.isEmpty {
            view.addSubview(emptyStateWishList)
        }
    
//        view.addSubview(cardTest)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
               emptyStateWishList.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               emptyStateWishList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               emptyStateWishList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])
    }
    
    
}
