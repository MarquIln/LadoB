//
//  CardWishList.swift
//  LadoB
//
//  Created by Vítor Bruno on 15/05/25.
//

import UIKit

class CardWishList: UICollectionViewCell {

    static let identifier: String = "cardCollectionCell"
    
    //imagem em destaque do album
    private lazy var albumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 174).isActive = true
        image.widthAnchor.constraint(equalToConstant: 174).isActive = true
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        
        return image
    }()
    
    //nome da musica
    private lazy var labelAlbumName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Fonts.subtitle
        label.textColor = .pink1
        return label
    }()
    
    //nome do artista, menorzinho q nem no figma
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
    
    //stack view pra juntar a imagem e as labels
    private lazy var stackViewCard: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [albumImage, stackViewLabels])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    //atributos
    var artistName: String? {
        didSet {
            labelArtist.text = artistName
        }
    }
    
    var albumName: String? {
        didSet {
            labelAlbumName.text = albumName
        }
    }
    
    var albumImageURL: URL? {
        didSet {
            guard let url = albumImageURL else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.albumImage.image = image
                    }
                }
            }.resume()
        }
    }
    
    func config(imageURL: UIImage, artistName: String, albumName: String) {
        albumImage.image = imageURL
        labelArtist.text = artistName
        labelAlbumName.text = albumName
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: extensao viewCodeProtocol
extension CardWishList: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
        
    }
    
    func addSubviews() {
        addSubview(stackViewCard)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewCard.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackViewCard.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackViewCard.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackViewCard.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    
}
