//
//  CardAlbumModal.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 16/05/25.
//
import UIKit

class CardAlbumModal: UIView {
 
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 370).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 370).isActive = true
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
    
    lazy var artistNameAndYearLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.subtitle
        label.text = "Artist name"
        label.textColor = .pink1

        return label
    }()
    
    lazy var totalMusicsLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.subtitle
        label.text = "Total musics"
        label.textColor = .gray
        return label
    }()
    
    var imageName: String? {
            didSet {
                if let name = imageName {
                    imageView.image = UIImage(named: name)
                }
            }
        }
    
    var title: String? {
        didSet {
            albumNameLabel.text = title
        }
    }
    
    var artistName: String? {
        didSet {
            artistNameAndYearLabel.text = artistName
        }
    }
    
    var totalMusics: String? {
        didSet {
            totalMusicsLabel.text = totalMusics
        }
    }
    
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, albumNameLabel, artistNameAndYearLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
}

extension CardAlbumModal: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
