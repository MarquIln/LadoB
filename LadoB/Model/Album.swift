import Foundation

struct Album: Codable, Equatable {
    let id: UUID?
    let title: String
    let artist: String
    let decade: Int
    let genre: Genre
    let coverAsset: String
    var isWished: Bool?
    var isFavorite: Bool?
    var isDisco: Bool?
    var biography: String?
    var qtdMusicsAndDuration: String?
  
    init(id: UUID = UUID(), title: String, artist: String, decade: Int, genre: Genre, coverAsset: String, isWished: Bool? = nil, isFavorite: Bool? = nil, isDisco: Bool? = nil) {
        self.id = id
        self.title = title
        self.artist = artist
        self.decade = decade
        self.genre = genre
        self.coverAsset = coverAsset
        self.isWished = isWished
        self.isFavorite = isFavorite
        self.isDisco = isDisco
    }
}
