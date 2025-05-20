//
//  AlbumModalViewController.swift
//  LadoB
//
//  Created by Eduardo Ferrari on 16/05/25.
//

import UIKit

class AlbumModalViewController: UIViewController {
    
    var album: Album!
    
    
    lazy var headerView: HeaderViewAlbumModal = {
        let view = HeaderViewAlbumModal()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.addButtonIsEnabled = true
        view.okButtonAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        view.backgroundColor = .purple1
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self.createLayoutSection(height: 490)
            case 1:
                return self.createHorizontalButtonsLayout()
            case 2:
                return self.createLayoutSection2(height: 220)
            case 3:
                return self.createDiscographyLayout()
            default:
                return self.createLayoutSection(height: 100)
            }
        }

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false

        // Registre suas células
        cv.register(AlbumCVCell.self, forCellWithReuseIdentifier: AlbumCVCell.identifier)
        cv.register(ButtonsModalCVCell.self, forCellWithReuseIdentifier: ButtonsModalCVCell.identifier)
        cv.register(BiographyCVCell.self, forCellWithReuseIdentifier: BiographyCVCell.identifier)
        cv.register(DiscographyCVCell.self, forCellWithReuseIdentifier: DiscographyCVCell.identifier)
        cv.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )

        return cv
    }()
    
    var discography: [Album] = []
    
    func loadAllAlbums0() -> [Album] {
        guard let url = Bundle.main.url(forResource: "mockedData_with_qtd", withExtension: "json") else {
            print("Arquivo JSON não encontrado")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Album].self, from: data)
            return decoded
        } catch {
            print("Erro ao decodificar JSON: \(error)")
            return []
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        self.sheetPresentationController?.preferredCornerRadius = 30
        headerView.addButtonIsEnabled = true
        if let album = album {
                discography = loadAllAlbums0().filter { $0.artist == album.artist }
        }
        setup()
        collectionView.reloadData()
    }
    
    
    
}

extension AlbumModalViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}
