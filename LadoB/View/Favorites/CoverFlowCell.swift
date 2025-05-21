//
//  CoverCellView.swift
//  LadoB
//
//  Created by Marcos on 20/05/25.
//

import UIKit

class CoverFlowCell: UICollectionViewCell {
    static let identifier = "CoverFlowCell"

    private lazy var albumImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(albumImageView)
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with album: Album) {
        albumImageView.image = UIImage(named: album.coverAsset)
    }
}
