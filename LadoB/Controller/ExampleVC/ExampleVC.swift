//
//  Examplevc.swift
//  LadoB
//
//  Created by Marcos on 12/05/25.
//

import UIKit

class ExampleVC: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lado B"
        label.textColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let cardView = CardTableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        cardView.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
}

extension ExampleVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(cardView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            cardView.topAnchor.constraint(equalTo: view.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    
}
