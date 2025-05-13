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
    
    lazy var buttonView: Button = {
        let view = Button()
        view.button.setTitle("Tap me!", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        setup()
    }
}

extension ExampleVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(buttonView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            buttonView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    
}
