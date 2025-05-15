//
//  WishListVC.swift
//  LadoB
//
//  Created by Vítor Bruno on 14/05/25.
//

import UIKit

class WishListVC: UIViewController {

    lazy var emptyStateWishList: EmptyState = {
            var empty = EmptyState()
            empty.translatesAutoresizingMaskIntoConstraints = false
            empty.titleText = "Nenhum LP cadastrado ainda"
            empty.descriptionText = """
                                    Os álbuns, coletâneas e listas cadastradas
                                    e criadas por você aparacerão aqui
                                    """
            return empty
        }()
    
    lazy var cardTest: CardWishList = {
        var card = CardWishList()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.artistName = "Teste"
        card.songName = "Musica banger"
        card.albumImageURL = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8bxzV8TBveyP5mvFTKvQr_bIHS38J2r0FEA&s")
        
        card.setup()
        return card
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        
        
        setup()
    }

}

extension WishListVC: ViewCodeProtocol {
    func addSubviews() {
        //view.addSubview(emptyStateWishList)
        view.addSubview(cardTest)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
//            emptyStateWishList.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
//                       emptyStateWishList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//                       emptyStateWishList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//                      emptyStateWishList.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardTest.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cardTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    
}
