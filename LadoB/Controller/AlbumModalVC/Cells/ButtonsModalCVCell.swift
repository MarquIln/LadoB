//
//  ButtonsModalCVCell.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 19/05/25.
//
import UIKit

class ButtonsModalCVCell: UICollectionViewCell {
    
    static let identifier = "ButtonsModalCVCell"
    
    private lazy var button: ButtonsAlbumModal = {
        let button0 = ButtonsAlbumModal()
        button0.translatesAutoresizingMaskIntoConstraints = false
        //button0.backgroundColor = .red
        return button0
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        //contentView.clipsToBounds = true
        self.layer.cornerRadius = 12
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(title: String, iconButtonimage: String?) {
        button.titleText = title
        button.iconName = iconButtonimage
    }
}

extension ButtonsModalCVCell: ViewCodeProtocol{
    func addSubviews() {
        contentView.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    
    
}
