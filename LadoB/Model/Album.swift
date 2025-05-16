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
    let coverURL: String
    var isWished: Bool? = false

    init(id: UUID = UUID(), title: String, artist: String, decade: Int, genre: Genre, coverURL: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.decade = decade
        self.genre = genre
        self.coverURL = coverURL
    }
    
    //função para retornar o json de albuns e usar no app
    static func loadAlbunsFromJSON() -> [Album] {
        
        //caminho do arquivo
        guard let url = Bundle.main.url(forResource: "mockedData", withExtension: "json"),
                let data = try? Data(contentsOf: url), // le o arquivo pra transofrma em data
                let albunsListFromJson = try? JSONDecoder().decode([Album].self, from: data)
                //tenta decodar a data em um array de Album
        else {
            
            return []
        }
        
        return albunsListFromJson
    }
    
}
