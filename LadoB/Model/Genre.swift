//
//  Genre.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//


enum Genre: String, Codable, CaseIterable {
    case rock = "Rock"
    case pop = "Pop"
    case jazz = "Jazz"
    case blues = "Blues"
    case hipHop = "Hip Hop"
    case electronic = "Electronic"
    case classical = "Classical"
    case reggae = "Reggae"
    case metal = "Metal"
    case country = "Country"
    case heavy_metal = "Heavy Metal"
    case folk = "Folk"
    case rnb = "R&B"
    case punk = "Punk"
    case soul = "Soul"
    case indie = "Indie"
    case latin = "Latin"
    case funk = "Funk"
    case disco = "Disco"
    case gospel = "Gospel"
    case kpop = "K-Pop"
    case other = "Other"
    case hard_rock = "Hard Rock"
    case grunge = "Grunge"
    case alternativeRock = "Alternative Rock"
    case mpb = "MPB"
    case bossaNova = "Bossa Nova"
    case jazzBossaNova = "Jazz/Bossa Nova"
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
