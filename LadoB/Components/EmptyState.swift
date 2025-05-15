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
        label.font = UIFont(name: "SFPro-Bold", size: 20)
        label.textAlignment = .center
        label.textColor = .white2
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white3
        return label
    }()

    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            titleLabel, descriptionLabel, button,
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .purple1
        stack.spacing = 16
        return stack
    }()
    
    private lazy var button: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.buttonText("Adicionar um LP agora")
        button.buttonHeight = 40
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    

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

    @objc func buttonTapped() {
        //buttonAction()
        //fazer ação do botão
    }

}

extension EmptyState: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(stack)

    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 20
            ),
            stack.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -20
            ),

            button.topAnchor.constraint(
                equalTo: stack.bottomAnchor,
                constant: 16
            ),

            button.heightAnchor.constraint(equalToConstant: 40),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

}
