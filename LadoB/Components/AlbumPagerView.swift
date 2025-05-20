//
//  AlbumPagerView.swift
//  LadoB
//
//  Created by Marcos on 20/05/25.
//

import UIKit

class AlbumPagerCell: FSPagerViewCell {

    let titleLabel = UILabel()
    let artistLabel = UILabel()
    let yearLabel = UILabel()
    let infoStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white

        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true

        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label

        artistLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        artistLabel.textAlignment = .center
        artistLabel.textColor = .secondaryLabel

        yearLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        yearLabel.textAlignment = .center
        yearLabel.textColor = .tertiaryLabel

        infoStack.axis = .vertical
        infoStack.spacing = 4
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(artistLabel)
        infoStack.addArrangedSubview(yearLabel)

        contentView.addSubview(infoStack)

        NSLayoutConstraint.activate([
            infoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            infoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with album: Album) {
        imageView?.image = UIImage(named: album.coverAsset)
        titleLabel.text = album.title
        artistLabel.text = album.artist
        yearLabel.text = "(\(album.decade))"
    }
}
