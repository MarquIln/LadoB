//
//  Card.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//

import UIKit

class Card: UIView {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.calloutBold
        label.text = "Album name"
        label.textColor = .pink2
        label.numberOfLines = 0

        return label
    }()

    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.subtitle
        label.text = "Artist name"
        label.textColor = .pink1

        return label
    }()


    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            albumNameLabel, artistNameLabel,
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return stackView
    }()
    
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .pink1

        return imageView
    }()

    lazy var albumStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView, labelStackView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.backgroundColor = .purple1

        return stackView
    }()
    
    lazy var cardStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            albumStackView, buttonImageView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    func config(imageURL: UIImage, artistName: String, albumName: String) {
        imageView.image = imageURL
        artistNameLabel.text = artistName
        albumNameLabel.text = albumName
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
}

extension Card: ViewCodeProtocol {
    func addSubviews() {
        addSubview(cardStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cardStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -12
            ),
            cardStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            cardStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            imageView.heightAnchor.constraint(equalToConstant: 58),
            imageView.widthAnchor.constraint(equalToConstant: 58),
            
            buttonImageView.heightAnchor.constraint(equalToConstant: 22),
            buttonImageView.widthAnchor.constraint(equalToConstant: 11)
        ])
    }
}
