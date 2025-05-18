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
    var filteredAlbums: [Album] = []
    
    lazy var emptyStateWishList: EmptyState = {
            var empty = EmptyState()
            empty.translatesAutoresizingMaskIntoConstraints = false
            empty.titleText = "Nenhum LP cadastrado ainda"
            empty.descriptionText = """
                                    Procure um álbum que gostaria de ter em sua Discoteca, salve no Radar para lembrar na hora que estiver garimpando por aí.
                                    """
        empty.buttonAction = { [weak self] in
            self?.tabBarController?.selectedIndex = 0
        }
            return empty
        }()

    lazy var wishListcollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createSectionLayout())
        
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -6)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .purple1
        collectionView.register(CardWishList.self, forCellWithReuseIdentifier: CardWishList.identifier)
        
        return collectionView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Álbum, Artista, Banda"
        searchController.searchBar.searchTextField.font = Fonts.bodyBold
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        
        
        navigationItem.title = "No Radar"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]
        
        configureSearchController()
        
        albuns[8].isWished = true
        albuns[80].isWished = true
        albuns[33].isWished = true
        albuns[25].isWished = true
        albuns[7].isWished = true
        
        wishedAlbuns = albuns.filter({$0.isWished == true})
    
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
        section.interGroupSpacing = 20
                                                        
        //layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension WishListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive && !filteredAlbums.isEmpty {
            
            return filteredAlbums.count
        }else{
            
            return wishedAlbuns.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CardWishList.identifier, for: indexPath) as? CardWishList else {fatalError()}
        
        let album: Album
        
        if searchController.isActive && !filteredAlbums.isEmpty {
         
            album = filteredAlbums[indexPath.row]
        }else{
            
            album = wishedAlbuns[indexPath.row]
        }
        
        if let image = UIImage(named: album.coverAsset) {
            cell.config(imageURL: image, artistName: album.artist, albumName: album.title)
        }

        return cell
    }
    
    
}

extension WishListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        
        if !query.isEmpty {
            filteredAlbums = wishedAlbuns.filter { $0.title.lowercased().contains(query.lowercased()) ||
                $0.artist.lowercased().contains(query.lowercased())
            }
        }else{
            filteredAlbums = []
        }
        
        wishListcollectionView.reloadData()
        
    }
    
}

extension WishListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension WishListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        let albumSelected: Album = wishedAlbuns[indexPath.row]
        
        print("Album clicado: \(albumSelected.title)")
        
        
        present(ExampleVC(), animated: true)
    }
    
}

