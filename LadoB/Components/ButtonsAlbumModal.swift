//
//  ButtonsAlbumModal.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 16/05/25.
//
import UIKit

class ButtonsAlbumModal: UIView {
 
        lazy var iconImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(systemName: "checkmark.circle.fill") 
          imageView.tintColor = UIColor(named: "DarkPurple") ?? .darkGray
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
          imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
          return imageView
      }()
      
        lazy var titleLabel: UILabel = {
          let label = UILabel()
          label.text = "Tenho"
          //label.textColor = UIColor(named: "DarkPurple") ?? .darkGray
          label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
      
        lazy var stack: UIStackView = {
          let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
          stack.axis = .horizontal
          stack.spacing = 8
          stack.alignment = .center
          stack.translatesAutoresizingMaskIntoConstraints = false
          return stack
      }()
    
    
    var iconName: String? {
            didSet {
                if let name = iconName {
                    iconImageView.image = UIImage(named: name)
                }
            }
        }
        
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
}

extension ButtonsAlbumModal: ViewCodeProtocol {
    func addSubviews() {
        //addSubview(cardStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            //
        ])
    }
}
