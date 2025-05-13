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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ExampleVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    
}
