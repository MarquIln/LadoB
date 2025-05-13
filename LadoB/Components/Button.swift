//
//  ButtonComponent.swift
//  LadoB
//
//  Created by Vítor Bruno on 13/05/25.
//

import UIKit

class Button: UIView {

    //MARK: BOTÃO
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "SFPro-Bold", size: 16)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.backgroundColor = .yellow1

        return button
    }()

    var buttonText: String? {
        didSet {
            button.setTitle(buttonText, for: .normal)
        }
    }

    var buttonHeight: Double? {
        didSet {
            if let buttonHeight {
                button.heightAnchor.constraint(
                    equalToConstant: CGFloat(buttonHeight)
                ).isActive = true
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Button: ViewCodeProtocol {
    func addSubviews() {
        addSubview(button)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
