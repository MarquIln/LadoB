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
        label.font = UIFont(name: "SFPro-Bold", size: 20)
        label.text = "Biografia"
        label.textColor = .pink2
        label.numberOfLines = 0

        return label
    }()
    
    lazy var biographyField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        //textView.backgroundColor = UIColor(named: "Background-Tertiary")
        textView.text = ""
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .label
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
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
        addSubview(mainStack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
