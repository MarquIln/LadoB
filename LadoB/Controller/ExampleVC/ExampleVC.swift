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
    
    lazy var emptyView: EmptyState = {
        var empty = EmptyState()
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.titleText = "Nenhum LP cadastrado ainda"
        empty.descriptionText = """
                                Os álbuns, coletâneas e listas cadastradas
                                e criadas por você aparacerão aqui
                                """
        return empty
    }()
    

    ////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple1
        setup()
    }
}

extension ExampleVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(emptyView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            emptyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
           emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    
}
