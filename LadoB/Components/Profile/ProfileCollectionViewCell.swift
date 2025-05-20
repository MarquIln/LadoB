//
//  ProfileCollectionViewCell.swift
//  LadoB
//
//  Created by Vítor Bruno on 19/05/25.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewListCell {
    
    static let reuseIdentifier = "ProfileCollectionViewCell"
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tintColor = .pink2
        label.font = UIFont(name: "SFProRounded-Bold", size: 34)
        return label
    }()
    
    lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Fonts.text
        label.tintColor = .pink3
        return label
    }()
    
    private lazy var buttonImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right", withConfiguration: config)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .yellow1
        imageView.isUserInteractionEnabled = true

        return imageView
    }()
    
    lazy var stackViewTitleDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelTitle, labelDescription])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var stackViewLabelsImage: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewTitleDescription, buttonImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
}
