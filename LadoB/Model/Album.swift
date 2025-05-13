//
//  Albuns.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//

import Foundation

struct Album: Codable {
    var id = UUID()
    var title: String
    var artist: String
    var decade: Date
    var genre: Genre
    var cover: String
    
    init(id: UUID = UUID(), title: String, artist: String, decade: Date, genre: Genre, cover: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.decade = decade
        self.genre = genre
        self.cover = cover
    }
}
