//
//  EmptyState.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 13/05/25.
//

import UIKit

    
class EmptyState: UIView {
        
        private lazy var titleLabel: UILabel = {
            var label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            //label.font = UIFont(name: "SFProRounded-Bold", size: 17)
            label.textAlignment = .center
            //label.textColor = UIColor(named: "Label-Primary")
            return label
        }()
        
        private lazy var descriptionLabel: UILabel = {
            var label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            //label.font = UIFont(name: "SFProRounded-Regular", size: 17)
            label.textAlignment = .center
            label.numberOfLines = 0
            //label.textColor = .secondaryLabel
            return label
        }()
        
        private lazy var stack: UIStackView = {
            var stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, button])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = 16
            return stack
        }()
        
        private lazy var button: Button = {
            var button1 = Button()
            button1.button.setTitle("Adicionar um LP agora", for: .normal)
            button1.translatesAutoresizingMaskIntoConstraints = false
            return button1
        }()
        
    
//        private lazy var button: UIButton = {
//            var button = UIButton()
//            button.translatesAutoresizingMaskIntoConstraints = false
////            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
////            button.titleLabel?.font = UIFont(name: "SFProRounded-Semibold", size: 17)
//            button.backgroundColor = .systemBlue
//            button.layer.cornerRadius = 12
//            return button
//        }()
        
        
        var titleText: String? {
            didSet {
                titleLabel.text = titleText
            }
        }
        
        var descriptionText: String? {
            didSet {
                descriptionLabel.text = descriptionText
            }
        }
        
        
//        var buttonAction: () -> Void = {}
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
//        @objc func buttonTapped() {
//            buttonAction()
//        }
        
}
    
extension EmptyState: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        //addSubview(imageView)
        addSubview(stack)
        addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 32),
            
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    
}
