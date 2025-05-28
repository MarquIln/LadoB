//
//  SearchSectionHeader.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 15/05/25.
//

import UIKit

class SearchSectionHeader: UICollectionReusableView {
    
    static let identifier = "SearchSectionHeader"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.bodyBold
        label.textColor = .pink3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ text: String, color: UIColor? = nil, font: UIFont? = nil) {
        titleLabel.text = text
        if let color = color {
            titleLabel.textColor = color
        }
        if let font = font {
            titleLabel.font = font
        }
    }
}
