//
//  SearchTableView.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//

import UIKit

class CardTableView: UIView {
    private var groupedAlbums: [String: [Album]] = [:]
    private var sectionTitles: [String] = []

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default-cell")
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.reuseIdentifier)
        tableView.contentInsetAdjustmentBehavior = .automatic
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
    
    private func groupAndSortAlbums(_ albums: [Album]) {
        let sortedAlbums = albums.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }

        groupedAlbums = Dictionary(grouping: sortedAlbums) { album in
            String(album.title.prefix(1)).uppercased()
        }

        sectionTitles = groupedAlbums.keys.sorted()
    }


    private func buildContent() {
        guard let url = Bundle.main.url(forResource: "mockedData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Album].self, from: data) else {
            return
        }
        groupAndSortAlbums(decoded)
        tableView.reloadData()
    }

    func updateAlbums(_ albums: [Album]) {
        groupAndSortAlbums(albums)
        tableView.reloadData()
    }
}

extension CardTableView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(tableView)
        tableView.reloadData()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        return groupedAlbums[key]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.reuseIdentifier, for: indexPath) as? CardTableViewCell else {
            return UITableViewCell()
        }

        let key = sectionTitles[indexPath.section]
        if let album = groupedAlbums[key]?[indexPath.row] {
            cell.config(with: album)
        }

        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = .yellow1
        tableView.sectionIndexBackgroundColor = .purple1
        return sectionTitles
    }
}

extension CardTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}
