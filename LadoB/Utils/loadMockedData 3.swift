//
//  loadMockedData.swift
//  LadoB
//
//  Created by Marcos on 14/05/25.
//

import Foundation

struct JSONLoader {
    static func loadAlbums(from filename: String) -> [Album] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Arquivo \(filename).json não encontrado.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let albums = try decoder.decode([Album].self, from: data)
            return albums
        } catch {
            print("Erro ao carregar os álbuns: \(error)")
            return []
        }
    }
}
