//
//  CardSmallSearch.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 14/05/25.
//

import UIKit

class CardSmallSearch: UIView {
    
    lazy var imageCard: UIImageView = {
        let card = UIImageView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.masksToBounds = true
        card.image = UIImage(named: "testeChesterSmall")
        card.heightAnchor.constraint(equalToConstant: 102).isActive = true
        card.widthAnchor.constraint(equalToConstant: 102).isActive = true
        card.layer.cornerRadius = 4
        return card
    }()
    
    private lazy var albumTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 17)
        label.textAlignment = .center
        label.textColor = .white2
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 14)
        label.textAlignment = .center
        label.textColor = .white3
        return label
    }()
    
    
    //stacks
    lazy var stackViewLabels: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [albumTitleLabel, artistLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1
        return stackView
    }()
    
    lazy var mainStack: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [imageCard, stackViewLabels])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    //View
    lazy var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black4
        view.layer.cornerRadius = 12
        return view
    }()
    
    
    var image: UIImage? {
        didSet {
            imageCard.image = image
        }
    }
    
    var albumTitle: String? {
        didSet {
            albumTitleLabel.text = albumTitle
        }
    }

    var artistTitle: String? {
        didSet {
            artistLabel.text = artistTitle
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        self.heightAnchor.constraint(equalToConstant: 163).isActive = true
        self.widthAnchor.constraint(equalToConstant: 126).isActive = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CardSmallSearch: ViewCodeProtocol {
    func addSubviews() {
        containerView.addSubview(mainStack)
        addSubview(containerView)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCard.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            imageCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            imageCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
//            imageCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 49),
            
            stackViewLabels.topAnchor.constraint(equalTo: imageCard.bottomAnchor, constant: 4),
            stackViewLabels.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            stackViewLabels.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            stackViewLabels.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            
            ])
    }
    
    
    
}
