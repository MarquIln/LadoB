//
//  ButtonComponent.swift
//  LadoB
//
//  Created by Vítor Bruno on 13/05/25.
//

import UIKit

class Button: UIButton {

    var buttonHeight: Double? {
        didSet {
            if let height = buttonHeight {
                heightAnchor.constraint(equalToConstant: CGFloat(height))
                    .isActive = true
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

    private func setup() {
        setTitle("", for: .normal)
        setImage(UIImage(), for: .normal)
        layer.cornerRadius = 8
        titleLabel?.font = Fonts.bodyBold
        setTitleColor(.purple1, for: .normal)
        backgroundColor = .yellow1
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        print("botão clicado")
    }

    func buttonText(_ text: String) {
        setTitle(text, for: .normal)
    }

    func buttonImage(_ image: UIImage) {
        setImage(image, for: .normal)
    }

}
