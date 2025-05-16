//
//  CardTableViewCell.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CardTableViewCell"

    private var card: Card = {
        let card = Card()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(with album: Album) {
        if let image = UIImage(named: album.coverAsset) {
            card.config(
                imageURL: image,
                artistName: album.artist,
                albumName: album.title
            )
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
}

extension CardTableViewCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(card)
        contentView.backgroundColor = .purple1
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),
            card.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8
            ),
            card.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
            ),
            card.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
            ),
        ])
    }
}
