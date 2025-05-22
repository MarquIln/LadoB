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
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    Aqui depois botar year e quantidade musicas
//    func config(with album: Album, title: String, artist: String, image: String?) {
//        cardView.title = title
//        cardView.artistName = artist
//        cardView.imageName = image
//        cardView.totalMusics = album.qtdMusicsAndDuration ?? "Duração indisponível"  /*"\(album.totalTracks ?? 0)"*/
//        
//    }
    
    func config(with album: Album) {
        cardView.title = album.title
        cardView.artistName = "\(album.artist) (\(album.decade))"
        cardView.imageName = album.coverAsset
        cardView.totalMusics = album.qtdMusicsAndDuration
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
        contentView.addSubview(cardView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            ])
    }
    
    
    
}
