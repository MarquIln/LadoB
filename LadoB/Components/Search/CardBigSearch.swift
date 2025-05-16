//
//  CardBigSearch.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 14/05/25.
//
import UIKit
class CardBigSearch: UIView {
    
    private lazy var imageCard: UIImageView = {
        let card = UIImageView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.masksToBounds = true
        card.image = UIImage(named: "Checker")
        card.heightAnchor.constraint(equalToConstant: 150).isActive = true
        card.widthAnchor.constraint(equalToConstant: 150).isActive = true
        card.layer.cornerRadius = 4
        return card
    }()
    
    private lazy var albumTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 17)
        label.textAlignment = .center
        label.textColor = .pink1
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 14)
        label.textAlignment = .center
        label.textColor = .pink3
        return label
    }()
    
    private lazy var anoAlbumLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 14)
        label.textAlignment = .center
        label.textColor = .pink3
        return label
    }()
    
    private lazy var arrowButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .yellow1
        button.contentHorizontalAlignment = .right
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 16).isActive = true
        button.addTarget(self, action: #selector(buttonTappedArrow), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Compartilhar", for: .normal)
        button.titleLabel?.font = Fonts.footNoteBold
        button.setTitleColor(UIColor.yellow1, for: .normal)
        button.addTarget(self, action: #selector(buttonTappedShare), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    
    
    
    //stacks
    lazy var stackViewLabels: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [albumTitleLabel, artistLabel, anoAlbumLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var arrowStack: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [arrowButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var shareStack: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [shareButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var mainStack: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [stackViewLabels, arrowStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 62).isActive = true
        stackView.alignment = .top
        //stackView.spacing = 8
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
    
    var anoTitle: String? {
        didSet {
            anoAlbumLabel.text = anoTitle
        }
    }
    
    
    @objc func buttonTappedArrow() {
        //fazer ação do botão Arrow
    }
    
    @objc func buttonTappedShare() {
        //fazer ação do botão Share
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        self.heightAnchor.constraint(equalToConstant: 272).isActive = true
        self.widthAnchor.constraint(equalToConstant: 174).isActive = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CardBigSearch: ViewCodeProtocol {
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(imageCard)
        containerView.addSubview(mainStack)
        containerView.addSubview(shareStack)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            imageCard.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            imageCard.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            imageCard.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),

            mainStack.topAnchor.constraint(equalTo: imageCard.bottomAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            


            shareStack.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 4),
            shareStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            shareStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            shareStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        
            
            ])
    }
    
    
    
}
