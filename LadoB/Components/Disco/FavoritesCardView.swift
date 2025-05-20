//
//  FavoritesCardView.swift
//  LadoB
//
//  Created by Marcos on 19/05/25.
//

import UIKit

class FavoritesCardView: UIView {
    
    private lazy var albumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 174).isActive = true
        image.widthAnchor.constraint(equalToConstant: 174).isActive = true
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var labelAlbumName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Fonts.subtitle
        label.textColor = .pink1
        return label
    }()
    
    private lazy var labelArtist: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Fonts.footNote
        label.textColor = .pink3
        return label
    }()
    
    private lazy var stackViewLabels: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelAlbumName, labelArtist])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var stackViewCard: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [albumImage, stackViewLabels])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(imageURL: UIImage, artistName: String, albumName: String) {
        albumImage.image = imageURL
        labelArtist.text = artistName
        labelAlbumName.text = albumName
    }
}

extension FavoritesCardView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackViewCard)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewCard.topAnchor.constraint(equalTo: topAnchor),
            stackViewCard.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackViewCard.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewCard.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
