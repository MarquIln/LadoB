//
//  BiographyCVCell.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 19/05/25.
//
import UIKit
class BiographyCVCell: UICollectionViewCell {
    
    static let identifier = "BiographyCVCell"
    
    private lazy var biographyComponent: BiographyDescription = {
        let view = BiographyDescription()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with album: Album, biography: String?) {
        biographyComponent.textBiographyField = biography
    }
}

extension BiographyCVCell: ViewCodeProtocol{
    func addSubviews() {
        //contentView.addSubview(backgroundImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //
            ])
    }
    
    
    
}
