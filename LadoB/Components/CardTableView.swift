//
//  SearchTableView.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//

import UIKit

class CardTableView: UIView {
    private var albums: [Album] = []

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default-cell")
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .purple1
        
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        buildContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildContent() {
        albums = Album.loadAlbums() //coloquei a funcao dentro do model
    }
    
    func updateAlbums(_ albums: [Album]) {
        self.albums = albums
        tableView.reloadData()
    }
}

extension CardTableView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension CardTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.reuseIdentifier, for: indexPath) as? CardTableViewCell else {
            return UITableViewCell()
        }
        
        cell.config(with: albums[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        return cell
    }
}

extension CardTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
}
