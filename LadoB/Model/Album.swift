//
//  Albuns.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//

import Foundation

struct Album: Decodable {
    let id: UUID?
    let title: String
    let artist: String
    let decade: Int
    let genre: Genre
    let coverAsset: String
    var biography: String?
    var qtdMusicsAndDuration: String?
    var isWished: Bool?

    init(id: UUID = UUID(), title: String, artist: String, decade: Int, genre: Genre, coverAsset: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.decade = decade
        self.genre = genre
        self.coverAsset = coverAsset
    }
}
