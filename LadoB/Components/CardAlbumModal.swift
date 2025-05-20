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
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Semibold", size: 22)
        label.text = "Album name"
        label.textColor = .pink1
        label.clipsToBounds = true
        label.lineBreakMode = .byTruncatingTail

        return label
    }()
    
    lazy var artistNameAndYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 19)
        label.text = "Artist name"
        label.textColor = .pink1
        label.clipsToBounds = true

        return label
    }()
    
    lazy var totalMusicsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 16)
        //label.text = "Total musics"
        label.textColor = .pink4
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
    
//    lazy var stackLabels: UIStackView = {
//        let stackLabels0 = UIStackView(arrangedSubviews: [albumNameLabel,artistNameAndYearLabel, totalMusicsLabel])
//        stackLabels0.axis = .vertical
//        stackLabels0.spacing = 4
//        stackLabels0.translatesAutoresizingMaskIntoConstraints = false
//        return stackLabels0
//    }()
//    
//    lazy var mainStack: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [imageView,stackLabels])
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.spacing = 16
//        stackView.alignment = .fill
//        stackView.distribution = .fill
//        return stackView
//    }()
    
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
        //addSubview(mainStack)
        addSubview(imageView)
        addSubview(albumNameLabel)
        addSubview(artistNameAndYearLabel)
        addSubview(totalMusicsLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: self.topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            
//            imageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16),
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
//            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
//            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 370),
            
            //imageView.heightAnchor.constraint(equalToConstant: 370),
            
            albumNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            albumNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            artistNameAndYearLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 4),
            artistNameAndYearLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            artistNameAndYearLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            totalMusicsLabel.topAnchor.constraint(equalTo: artistNameAndYearLabel.bottomAnchor, constant: 4),
            totalMusicsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalMusicsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalMusicsLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ])
    }
}
