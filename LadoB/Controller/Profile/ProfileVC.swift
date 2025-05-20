//
//  ProfileVC.swift
//  LadoB
//
//  Created by Vítor Bruno on 19/05/25.
//

import UIKit

class ProfileVC: UIViewController {

    let userTest = User(email: "teste@mail.com", password: "1234", subscriptionPlain: .free, connectedApps: [.appleMusic, .instagram], albunsOnDisco: 32, albunsOnFavorites: 8, albunsOnWishList: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple1
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Perfil"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]
    }
    
    lazy var profileCollectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -6)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .purple2
        collectionView.register(CardWishList.self, forCellWithReuseIdentifier: CardWishList.identifier)
        return collectionView
    }()

}

extension ProfileVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 2 {
            return 3
        }
        return userTest.connectedApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath) as! ProfileCollectionViewCell
        
        //colocar o conteudo da celula a depender da section do index path...
    }
    
        
    
}
