//
//  Genre.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//


enum Genre: String, Codable, CaseIterable {
    case Rock
    case Pop
    case Jazz
    case Blues
    case HipHop = "HipHop"
    case Electronic
    case Classical
    case Reggae
    case Metal
    case Country
    case Folk
    case Rnb = "R&B"
    case Punk
    case Soul
    case Indie
    case Latin
    case Funk
    case MPB
    case Disco
    case Gospel
    case Kpop = "K-Pop"
    case Other
}

extension Genre {
    var displayName: String {
        switch self {
        case .HipHop: return "Hip-Hop"
        case .Rnb: return "R&B"
        case .Kpop: return "K-Pop"
        case .Other: return "Other"
        default:
            return self.rawValue.capitalized
        }
    }
}
