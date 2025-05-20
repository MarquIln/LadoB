//
//  ProfileVC.swift
//  LadoB
//
//  Created by Vítor Bruno on 19/05/25.
//

import UIKit

class ProfileVC: UIViewController {

    let userTest = User(email: "teste@mail.com", password: "vitorlegal123456789##", subscriptionPlain: .free, connectedApps: [.appleMusic, .instagram], albunsOnDisco: 32, albunsOnFavorites: 8, albunsOnWishList: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        
        view.backgroundColor = .purple1
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .purple1
        navigationItem.title = "Perfil"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]
    }
    
    lazy var profileCollectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.headerMode = .supplementary
        config.backgroundColor = .purple2
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .purple2
        collectionView.isScrollEnabled = false
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.reuseIdentifier)
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
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let arrowImage = UIImage(systemName: "chevron.right", withConfiguration: config)
        let checkImage = UIImage(systemName: "checkmark", withConfiguration: config)
        
        let passwordCensored = userTest.password.map { _ in "*" }.joined()

        if indexPath.section == 0 {
            if indexPath.item == 0 {
                cell.config(labelTitle: userTest.email, labelDescription: "E-mail", arrowImg: nil)
            }else if indexPath.item == 1 {
                cell.config(labelTitle: passwordCensored, labelDescription: "Senha", arrowImg: arrowImage)
            }else if indexPath.item == 2 {
                cell.config(labelTitle: userTest.subscriptionPlain.rawValue, labelDescription: "Plano", arrowImg: arrowImage)
            }
            
        }
        
        if indexPath.section == 1 {
            cell.config(labelTitle: userTest.connectedApps[indexPath.row].rawValue, labelDescription: nil, arrowImg: checkImage)
        }
        
        if indexPath.section == 2 {
            if indexPath.item == 0 {
                cell.config(labelTitle: "\(userTest.albunsOnDisco) álbuns", labelDescription: "Discoteca", arrowImg: nil)
            }
            else if indexPath.item == 1 {
                cell.config(labelTitle: "\(userTest.albunsOnFavorites) álbuns", labelDescription: "Favoritos", arrowImg: nil)
            }
            else if indexPath.item == 2 {
                cell.config(labelTitle: "\(userTest.albunsOnWishList)", labelDescription: "Radar", arrowImg: nil)
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier,
            for: indexPath) as! SectionHeaderView

        let titles = ["Conta", "Apps conectados", "Indicadores"]
        header.setTitle(titles[indexPath.section])
        return header
    }
    
}

extension ProfileVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(profileCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    
        ])
    }
    
    
}
