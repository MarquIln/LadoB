//
//  SearchResultsCell.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 22/05/25.
//

import UIKit

class SearchResultsCell: UICollectionViewCell {
    static let identifier: String = "searchResultsCollectionCell"

    private lazy var albumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 106).isActive = true
        image.widthAnchor.constraint(equalToConstant: 105.67).isActive = true
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        
        return image
    }()

    private lazy var labelAlbumName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "SFPro-Regular", size: 15)
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
        stackView.spacing = 4.14
        return stackView
    }()

    func config(albumCover: UIImage?, artistName: String, albumName: String) {
        albumImage.image = albumCover
        labelArtist.text = artistName
        labelAlbumName.text = albumName
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension SearchResultsCell: ViewCodeProtocol {

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
