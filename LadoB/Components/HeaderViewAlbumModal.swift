//
//  HeaderViewAlbumModal.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 16/05/25.
//
import UIKit
class HeaderViewAlbumModal: UIView {
    // MARK: Subviews
    private lazy var backButton: UIButton = {
        var button = UIButton(type: .system)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "chevron.left")
        configuration.imagePadding = 4
        configuration.title = "Voltar"
        configuration.baseForegroundColor = UIColor(named: "Yellow1") // ou use .systemYellow, se não tiver custom
        configuration.contentInsets = .zero

        button.configuration = configuration
        button.titleLabel?.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        return button
    }()

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        label.textColor = .white
        return label
    }()

    private lazy var addButton: UIButton = {
        var button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Add", for: .disabled)
        button.setTitleColor(.systemGray, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [backButton, titleLabel, addButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalCentering
        return stack
    }()

    private lazy var separator: UIView = {
        var separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        return separator
    }()

    // MARK: Properties
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var addButtonIsEnabled: Bool = false {
        didSet {
            addButton.isEnabled = addButtonIsEnabled
        }
    }

    var backButtonAction: () -> Void = {}
    var addButtonAction: () -> Void = {}

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Actions
    @objc func backButtonTapped() {
        backButtonAction()
    }

    @objc func addButtonTapped() {
        addButtonAction()
    }
}

extension HeaderViewAlbumModal: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stack)
        addSubview(separator)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            separator.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 11),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.25)
        ])
    }
}
