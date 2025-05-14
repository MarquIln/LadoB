//
//  Genre.swift
//  LadoB
//
//  Created by Marcos on 13/05/25.
//


enum Genre: String, Codable, CaseIterable {
    case rock
    case pop
    case jazz
    case blues
    case hipHop = "hip_hop"
    case electronic
    case classical
    case reggae
    case metal
    case country
    case folk
    case rnb
    case punk
    case soul
    case indie
    case latin
    case funk
    case disco
    case gospel
    case kpop
    case other
}

extension Genre {
    var displayName: String {
        switch self {
        case .hipHop: return "Hip-Hop"
        case .rnb: return "R&B"
        case .kpop: return "K-Pop"
        case .other: return "Other"
        default:
            return self.rawValue.capitalized
        }
    }
}
