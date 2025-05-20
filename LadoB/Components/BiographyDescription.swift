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
        label.font = UIFont(name: "SFPro-Semibold", size: 21)
        label.text = "Biografia"
        label.textColor = .pink1
        label.numberOfLines = 0

        return label
    }()
    
//    lazy var biographyField: UITextView = {
//        let textView = UITextView()
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.layer.cornerRadius = 8
//        textView.font = UIFont.systemFont(ofSize: 16)
//        textView.textColor = .pink1
//        textView.backgroundColor = .clear
//        textView.isEditable = false
//        textView.isScrollEnabled = false
//        textView.textContainer.lineFragmentPadding = 0
//        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        return textView
//    }()
    
    lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 17)
        label.textColor = .pink1
        label.numberOfLines = 7
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
//    lazy var mainStack: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: //[biographyTitleLabel, biographyField])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.alignment = .fill
//        stack.spacing = 8
//        return stack
//    }()
    
    var textBiographyField: String? {
        didSet {
                guard let text = textBiographyField else { return }
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4 // ajuste como quiser

                let attributedText = NSAttributedString(
                    string: text,
                    attributes: [
                        .paragraphStyle: paragraphStyle,
                        .font: biographyLabel.font as Any,
                        .foregroundColor: biographyLabel.textColor as Any
                    ]
                )
                biographyLabel.attributedText = attributedText
                biographyLabel.numberOfLines = 7
                biographyLabel.lineBreakMode = .byTruncatingTail
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
        addSubview(biographyLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            biographyTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            biographyTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            biographyTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            biographyLabel.topAnchor.constraint(equalTo: biographyTitleLabel.bottomAnchor, constant: 4),
            biographyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            biographyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            biographyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
        ])
    }
}
