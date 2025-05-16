//
//  LargeCardCVCell.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 15/05/25.
//

import UIKit

class LargeCardCVCell: UICollectionViewCell {
    
    static let identifier = "LargeCardCVCell"

    private lazy var cardView: CardBigSearch = {
        let view = CardBigSearch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(with album: Album, title: String, artist: String, image: UIImage?, bgColor: UIColor? = nil, bgImage: UIImage? = nil) {
        cardView.albumTitle = title
        cardView.artistTitle = artist
        cardView.image = image
        backgroundImage.image = bgImage
        backgroundImage.backgroundColor = bgColor
    }
}

extension LargeCardCVCell: ViewCodeProtocol {
    
    func addSubviews() {
        contentView.addSubview(backgroundImage)
        contentView.addSubview(cardView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 174),
            cardView.heightAnchor.constraint(equalToConstant: 272)
        ])
    }
}
