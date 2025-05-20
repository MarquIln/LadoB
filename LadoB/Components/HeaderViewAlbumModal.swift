//
//  HeaderViewAlbumModal.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 16/05/25.
//
import UIKit
class HeaderViewAlbumModal: UIView {
    // MARK: Subviews
//    private lazy var backButton: UIButton = {
//        var button = UIButton(type: .system)
//        
//        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(systemName: "chevron.left")
//        configuration.imagePadding = 4
//        configuration.title = "Voltar"
//        configuration.baseForegroundColor = UIColor(named: "Yellow1") // ou use .systemYellow, se não tiver custom
//        configuration.contentInsets = .zero
//
//        button.configuration = configuration
//        button.titleLabel?.font = UIFont(name: "SFProRounded-Semibold", size: 17)
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        button.isEnabled = false
//        button.isHidden = true
//
//        return button
//    }()

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "SFPro-Semibold", size: 17)
        label.textColor = .white
        label.text = "Álbum"
        return label
    }()

     lazy var okButton: UIButton = {
        var button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.yellow1, for: .normal)
        button.setTitle("Ok", for: .disabled)
        button.setTitleColor(.systemGray, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return button
    }()

    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews:[titleLabel, okButton])
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
            okButton.isEnabled = addButtonIsEnabled
        }
    }

    var backButtonAction: () -> Void = {}
    var okButtonAction: () -> Void = {}

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .purple1
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Actions
    @objc func backButtonTapped() {
        backButtonAction()
    }

    @objc func okButtonTapped() {
        okButtonAction()
    }
}

extension HeaderViewAlbumModal: ViewCodeProtocol {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(okButton)
        addSubview(separator)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),

                  
            okButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            okButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

                  
            separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
