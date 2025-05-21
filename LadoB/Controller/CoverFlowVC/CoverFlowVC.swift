//
//  CoverFlowVC.swift
//  LadoB
//
//  Created by Marcos on 20/05/25.
//

import UIKit

class CoverFlowVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {

    var albums: [Album] = []

    lazy var pagerView: FSPagerView = {
        let pager = FSPagerView()
        pager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pager.dataSource = self
        pager.delegate = self
        pager.itemSize = CGSize(width: 346, height: 346)
        pager.transformer = FSPagerViewTransformer(type: .coverFlow)
        pager.isInfinite = true
        pager.scrollDirection = .vertical
        pager.decelerationDistance = FSPagerView.automaticDistance
        pager.translatesAutoresizingMaskIntoConstraints = false
        return pager
    }()

    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pink2
        label.font = Fonts.bodyBold
        label.textAlignment = .center
        return label
    }()

    lazy private var artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Fonts.bodyBold
        label.textAlignment = .center
        return label
    }()

    lazy private var yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = Fonts.bodyBold
        label.textAlignment = .center
        return label
    }()

    private lazy var albumInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, artistLabel, yearLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy private var shareButton: UIButton = {
        let button = UIButton(type: .system)

        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "square.and.arrow.up.fill")
        config.baseBackgroundColor = .yellow1
        config.baseForegroundColor = .purple2
        config.cornerStyle = .medium
        config.imagePadding = 12

        let font = Fonts.bodyBold ?? UIFont.systemFont(ofSize: 17, weight: .bold)
        let attributedTitle = AttributedString("Compartilhar", attributes: AttributeContainer([.font: font]))
        config.attributedTitle = attributedTitle

        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)

        return button
    }()

    @objc func handleShareTapped() {
        guard albums.indices.contains(pagerView.currentIndex) else { return }
        let album = albums[pagerView.currentIndex]
        let message = "Escute o álbum \"\(album.title)\" de \(album.artist)!"
        let activityVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        setup()
        updateAlbumInfo(index: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAlbumInfo(index: 0)
    }

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return albums.count
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let album = albums[index]
        cell.imageView?.image = UIImage(named: album.coverAsset)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 16
        cell.imageView?.layer.masksToBounds = true
        cell.clipsToBounds = true
        cell.contentView.clipsToBounds = true
        return cell
    }

    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        updateAlbumInfo(index: pagerView.currentIndex)
    }

    private func updateAlbumInfo(index: Int) {
        guard albums.indices.contains(index) else { return }
        let album = albums[index]
        titleLabel.text = album.title
        artistLabel.text = album.artist
        yearLabel.text = "(\(album.decade))"
    }
}

extension CoverFlowVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(pagerView)
        view.addSubview(albumInfoStack)
        view.addSubview(shareButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            pagerView.topAnchor.constraint(equalTo: view.topAnchor),
            pagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pagerView.heightAnchor.constraint(equalToConstant: 500),

            albumInfoStack.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -20),
            albumInfoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            albumInfoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            shareButton.heightAnchor.constraint(equalToConstant: 46),
            shareButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
