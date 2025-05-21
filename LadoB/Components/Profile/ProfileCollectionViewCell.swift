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
        label.textAlignment = .left
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.font = Fonts.text
        label.textColor = .pink1
        return label
    }()
    
    lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Fonts.footNote
        label.textColor = .pink3
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.tintColor = .yellow1
        imageView.heightAnchor.constraint(equalToConstant: 19).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 11).isActive = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    lazy var stackViewTitleDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelTitle, labelDescription])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.backgroundColor = .purple2
        return stackView
    }()
    
    lazy var stackViewLabelsImage: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewTitleDescription, buttonImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 24
        stackView.backgroundColor = .purple2
        return stackView
    }()
    
    func config(labelTitle: String, labelDescription: String?, arrowImg: UIImage?){
        self.labelTitle.text = labelTitle
        self.labelDescription.text = labelDescription
        self.buttonImageView.image = arrowImg
        self.contentView.backgroundColor = .purple2
        
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        contentView.clipsToBounds = true
        contentView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileCollectionViewCell: ViewCodeProtocol {
    
    func setup(){
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(stackViewLabelsImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewLabelsImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackViewLabelsImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackViewLabelsImage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackViewLabelsImage.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    
}
