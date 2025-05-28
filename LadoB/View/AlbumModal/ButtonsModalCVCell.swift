//
//  ButtonsModalCVCell.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 19/05/25.
//
import UIKit

class ButtonsModalCVCell: UICollectionViewCell {
    
    var onTap: (() -> Void)?
    
    static let identifier = "ButtonsModalCVCell"
    
    private lazy var button: ButtonsAlbumModal = {
        let button0 = ButtonsAlbumModal()
        button0.translatesAutoresizingMaskIntoConstraints = false
        //button0.backgroundColor = .red
        return button0
    }()
    
    private lazy var tapOverlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        //contentView.clipsToBounds = true
        self.layer.cornerRadius = 12
        
        
    }
    
    @objc private func handleTap() {
        onTap?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setHighlight(isHighlighted: Bool) {
        button.backgroundColor = isHighlighted ? UIColor(named: "Yellow1") : .pink1
    }
    
    func config(title: String, iconButtonimage: String?) {
        button.titleText = title
        button.iconName = iconButtonimage
    }
}

extension ButtonsModalCVCell: ViewCodeProtocol{
    func addSubviews() {
        contentView.addSubview(button)
        contentView.addSubview(tapOverlayButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            tapOverlayButton.topAnchor.constraint(equalTo: contentView.topAnchor),
               tapOverlayButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
               tapOverlayButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               tapOverlayButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
            
            ])
    }
    
    
    
}
