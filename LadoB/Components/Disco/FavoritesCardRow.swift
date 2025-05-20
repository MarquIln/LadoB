//
//  FavoritesCardRow.swift
//  LadoB
//
//  Created by Marcos on 20/05/25.
//

import UIKit

class FavoritesRowCell: UITableViewCell {
    static let identifier = "FavoritesRowCell"

    private let leftCard: FavoritesCardView = {
        let view = FavoritesCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setup()
        view.widthAnchor.constraint(equalToConstant: 174).isActive = true
        return view
    }()

    private let rightCard: FavoritesCardView = {
        let view = FavoritesCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setup()
        view.widthAnchor.constraint(equalToConstant: 174).isActive = true
        return view
    }()

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .purple2
        backgroundColor = .purple2

        stack.addArrangedSubview(leftCard)
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(albums: [Album]) {
        leftCard.config(
            imageURL: UIImage(named: albums[0].coverAsset) ?? UIImage(),
            artistName: albums[0].artist,
            albumName: albums[0].title
        )

        if albums.count > 1 {
            if !stack.arrangedSubviews.contains(rightCard) {
                stack.addArrangedSubview(rightCard)
            }

            rightCard.config(
                imageURL: UIImage(named: albums[1].coverAsset) ?? UIImage(),
                artistName: albums[1].artist,
                albumName: albums[1].title
            )
        } else {
            if stack.arrangedSubviews.contains(rightCard) {
                stack.removeArrangedSubview(rightCard)
                rightCard.removeFromSuperview()
            }
        }
    }
}
