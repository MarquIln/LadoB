//
//  ViewCodeProtocol.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//

protocol ViewCodeProtocol {
    func addSubviews()
    func setupConstraints()
    func setup()
}

extension ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
}
