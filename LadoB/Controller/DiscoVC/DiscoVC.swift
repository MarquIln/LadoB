//
//  DiscoVC.swift
//  LadoB
//
//  Created by Marcos on 14/05/25.
//

import UIKit

class DiscoVC: UIViewController {
    var allAlbums: [Album] = []
    
    let emptyState: EmptyState = {
        let view = EmptyState()
        view.titleText = "Nenhum LP salvo ainda"
        view.descriptionText =
        "Os álbuns, coletâneas e listas cadastradas e criadas por você aparecerão aqui"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var sections: [Int] = []
    var rows: [[Album]] = []
    
    func buildRows(from albums: [Album]) -> [[Album]] {
        var rows: [[Album]] = []
        var currentRow: [Album] = []
        
        for (index, album) in albums.enumerated() {
            currentRow.append(album)
            if currentRow.count == 4 || index == albums.count - 1 {
                rows.append(currentRow)
                currentRow = []
            }
        }
        
        return rows
    }
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
        button.tintColor = .yellow1
        
        return button
    }()
    
    lazy var favoritesButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(favoritesTapped)
        )
        button.tintColor = .yellow3
        
        return button
    }()
    
    @objc func favoritesTapped() {
        print("Favorites Tapped")
    }
    
    @objc func addTapped() {
        print("Add Tapped")
    }
    
    let cardTableView = CardTableView()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Álbum, Artista, Banda, Gênero"
        searchController.searchBar.searchTextField.font = Fonts.bodyBold
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateAddButtonIcon() {
        let iconName = allAlbums.isEmpty ? "plus.circle.fill" : "heart.fill"
        addButton.image = UIImage(systemName: iconName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Discoteca"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.pink2
        ]
        
        navigationItem.rightBarButtonItem = addButton
        

        
        configureSearchController()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAddButtonIcon()
    }
    
}
