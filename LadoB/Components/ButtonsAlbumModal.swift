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
          imageView.image = UIImage(systemName: "custom.record.circle.fill.badge.sparkles.alt")
          //imageView.tintColor = UIColor(named: "DarkPurple") ?? .darkGray
          imageView.translatesAutoresizingMaskIntoConstraints = false
//          imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
//          imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
          return imageView
      }()
      
        lazy var titleLabel: UILabel = {
          let label = UILabel()
          label.text = "Tenho"
          label.textColor = .purple1
          label.font = UIFont(name: "SFPro-Semibold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
      
        lazy var stack: UIStackView = {
          let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
          stack.axis = .horizontal
          stack.spacing = 8
          stack.alignment = .center
          stack.distribution = .fillProportionally
          stack.translatesAutoresizingMaskIntoConstraints = false
          return stack
      }()
    
    
    var iconName: String? {
            didSet {
                if let name = iconName {
                    iconImageView.image = UIImage(systemName: name)
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
        
        self.layer.cornerRadius = 12
//        self.backgroundColor = UIColor(named: "LightPurple") ?? UIColor.systemGray6
        self.backgroundColor = .pink1
    
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
}

extension ButtonsAlbumModal: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            //
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -12),
            stack.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -8),
            
            
//            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 46)
            
            
        ])
    }
}
