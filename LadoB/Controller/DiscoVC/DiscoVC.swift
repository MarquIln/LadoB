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
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped),
        )
        return button
    }()

    @objc func addTapped() {
        print("Add Tapped")
    }

    let cardTableView: CardTableView = {
        let view = CardTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let searchController = UISearchController(searchResultsController: nil)

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Álbum, Artista, Banda, Gênero"
        searchController.searchBar.searchTextField.font = Fonts.bodyBold
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple2 

        navigationItem.title = "Discoteca"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.rightBarButtonItem = addButton
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        configureSearchController()

        setup()
    }
}
