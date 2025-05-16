//
//  DiscoVC.swift
//  LadoB
//
//  Created by Marcos on 14/05/25.
//

import UIKit

class DiscoVC: UIViewController {

    private let emptyState: EmptyState = {
        let view = EmptyState()
        view.titleText = "Nenhum LP salvo ainda"
        view.descriptionText =
            "Os álbuns, coletâneas e listas cadastradas e criadas por você aparecerão aqui"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var sections: [Int] = []
    private var rows: [[Album]] = []

    private func buildSections() {
        for _ in 0..<10 {
            sections.append(0)
        }
    }

    private func buildRows(from albums: [Album]) -> [[Album]] {
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
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped),
        )
        return button
    }()
    
    @objc private func addTapped() {
        print("Add Tapped")
    }

    let cardTableView = CardTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Discoteca"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.pink2]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addButton
        
        setup()
    }
}

extension DiscoVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(emptyState)
        view.backgroundColor = .purple1
        view.addSubview(cardTableView)

        cardTableView.translatesAutoresizingMaskIntoConstraints = false

        let albums: [Album] = JSONLoader.loadAlbums(from: "mockedData")
        rows = buildRows(from: albums)
        sections = Array(repeating: 0, count: rows.count)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyState.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 321
            ),
            emptyState.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            emptyState.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),

            cardTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
        ])
    }
}

extension DiscoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CardTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? CardTableViewCell
        else {
            return UITableViewCell()
        }

        let album: Album = rows[indexPath.section][indexPath.row]
        cell.config(with: album)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        emptyState.isHidden = sections.isEmpty
        cardTableView.isHidden = !sections.isEmpty
        return sections.count
    }
}
