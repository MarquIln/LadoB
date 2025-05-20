//
//  BiographyDescription.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 16/05/25.
//

import UIKit

class BiographyDescription: UIView {
 
    lazy var biographyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Bold", size: 20)
        label.text = "Biografia"
        label.textColor = .pink1
        label.numberOfLines = 0

        return label
    }()
    
    lazy var biographyField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .pink1
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return textView
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [biographyTitleLabel, biographyField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    var textBiographyField: String? {
        didSet {
            biographyField.text = textBiographyField
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

extension BiographyDescription: ViewCodeProtocol {
    func addSubviews() {
        addSubview(biographyTitleLabel)
        addSubview(biographyField)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            biographyTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            biographyTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            biographyTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            biographyField.topAnchor.constraint(equalTo: biographyTitleLabel.bottomAnchor, constant: 12),
            biographyField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            biographyField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            biographyField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
