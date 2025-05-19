//
//  AlbumCVCell.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 19/05/25.
//

import UIKit

class AlbumCVCell: UICollectionViewCell {
    
    static let identifier = "AlbumCVCell"
    
    private lazy var cardView: CardAlbumModal = {
        let view = CardAlbumModal()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Aqui depois botar year e quantidade musicas
    func config(with album: Album, title: String, artist: String, image: String?) {
        cardView.title = title
        cardView.artistName = artist
        cardView.imageName = image
        cardView.totalMusics = "total botar"    /*"\(album.totalTracks ?? 0)"*/
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumCVCell: ViewCodeProtocol{
    func addSubviews() {
        //contentView.addSubview(backgroundImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //
            ])
    }
    
    
    
}
