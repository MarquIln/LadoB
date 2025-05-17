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
        //addSubview(cardStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            //
        ])
    }
}
