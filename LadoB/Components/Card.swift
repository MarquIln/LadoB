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
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        return imageView
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.calloutBold
        label.text = "Artist name"
        
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.bodyBold
        label.text = "Album name"
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistNameLabel, albumNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, labelStackView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .purple1
        
        return stackView
    }()
    
    func config(artistName: String, albumName: String, albumImage: String) {
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
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
