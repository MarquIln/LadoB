import Foundation

struct Persistence {
    static let allAlbunsKey = "allAlbuns"

    private static func loadAndStoreMainJson(named filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Arquivo \(filename).json não encontrado.")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Album].self, from: data)

            let albumsWithUUID = decoded.map { album in
                Album(
                    id: album.id ?? UUID(),
                    title: album.title,
                    artist: album.artist,
                    decade: album.decade,
                    genre: album.genre,
                    coverAsset: album.coverAsset,
                    isWished: album.isWished,
                    isFavorite: album.isFavorite,
                    isDisco: album.isDisco,
                    biography: album.biography,
                    qtdMusicsAndDuration: album.qtdMusicsAndDuration
                )
            }

            let dataToSave = try JSONEncoder().encode(albumsWithUUID)
            UserDefaults.standard.set(dataToSave, forKey: allAlbunsKey)
        } catch {
            print("Erro ao processar JSON principal: \(error)")
        }
    }

    static func getAllAlbuns() -> [Album] {
        if let data = UserDefaults.standard.data(forKey: allAlbunsKey) {
            do {
                return try JSONDecoder().decode([Album].self, from: data)
            } catch {
                print("Erro ao decodificar allAlbuns: \(error)")
            }
        }

        // Se ainda não estiver carregado, faz a leitura inicial do JSON principal
        loadAndStoreMainJson(named: "mockedData")

        if let data = UserDefaults.standard.data(forKey: allAlbunsKey) {
            do {
                return try JSONDecoder().decode([Album].self, from: data)
            } catch {
                print("Erro ao decodificar allAlbuns após carregar: \(error)")
            }
        }

        return []
    }

    // MARK: - Chaves
    static let wishedAlbunsKey = "wishedAlbuns"
    static let discoAlbunsKey = "discoAlbuns"
    static let favesAlbunsKey = "favesAlbuns"

    // MARK: - Wishlist
    static func getWishedAlbuns() -> [Album] {
        if let data = UserDefaults.standard.data(forKey: wishedAlbunsKey) {
            do {
                let albumList = try JSONDecoder().decode([Album].self, from: data)
                let sortedList = albumList.sorted { $0.title.lowercased() < $1.title.lowercased() }
                return sortedList
            } catch {
                print("Erro ao decodificar wishedAlbuns: \(error.localizedDescription)")
            }
        }
        return []
    }

    static func saveToWishlist(_ album: Album) {
        var currentWishList = getWishedAlbuns()
        currentWishList.append(album)
        do {
            let data = try JSONEncoder().encode(currentWishList)
            UserDefaults.standard.set(data, forKey: wishedAlbunsKey)
        } catch {
            print("Erro ao codificar wishedAlbuns: \(error.localizedDescription)")
        }
    }

    static func removeFromWishlist(_ album: Album) {
        var currentWishList = getWishedAlbuns()
        currentWishList.removeAll { $0.id == album.id }
        do {
            let data = try JSONEncoder().encode(currentWishList)
            UserDefaults.standard.set(data, forKey: wishedAlbunsKey)
        } catch {
            print("Erro ao codificar wishedAlbuns após remoção: \(error.localizedDescription)")
        }
    }

    static func isOnWishedList(_ album: Album) -> Bool {
        return getWishedAlbuns().contains(album)
    }

    // MARK: - Disco Albuns
    static func getDiscoAlbuns() -> [Album] {
        if let data = UserDefaults.standard.data(forKey: discoAlbunsKey) {
            do {
                let albumList = try JSONDecoder().decode([Album].self, from: data)
                let sortedList = albumList.sorted { $0.title.lowercased() < $1.title.lowercased() }
                return sortedList
            } catch {
                print("Erro ao decodificar discoAlbuns: \(error.localizedDescription)")
            }
        }
        return []
    }

    static func saveToDisco(_ album: Album) {
        var currentDiscoList = getDiscoAlbuns()
        currentDiscoList.append(album)
        do {
            let data = try JSONEncoder().encode(currentDiscoList)
            UserDefaults.standard.set(data, forKey: discoAlbunsKey)
        } catch {
            print("Erro ao codificar discoAlbuns: \(error.localizedDescription)")
        }
    }

    static func removeFromDisco(_ album: Album) {
        var currentDiscoList = getDiscoAlbuns()
        currentDiscoList.removeAll { $0.id == album.id }
        do {
            let data = try JSONEncoder().encode(currentDiscoList)
            UserDefaults.standard.set(data, forKey: discoAlbunsKey)
        } catch {
            print("Erro ao codificar discoAlbuns após remoção: \(error.localizedDescription)")
        }
    }

    static func isOnDiscoList(_ album: Album) -> Bool {
        return getDiscoAlbuns().contains(album)
    }

    // MARK: - Faves Albuns
    static func getFaves() -> [Album] {
        if let data = UserDefaults.standard.data(forKey: favesAlbunsKey) {
            do {
                let albumList = try JSONDecoder().decode([Album].self, from: data)
                return albumList
            } catch {
                print("Erro ao decodificar favesAlbuns: \(error.localizedDescription)")
            }
        }
        return []
    }

    static func saveToFaves(_ album: Album) {
        var currentFavesList = getFaves()
        currentFavesList.append(album)
        do {
            let data = try JSONEncoder().encode(currentFavesList)
            UserDefaults.standard.set(data, forKey: favesAlbunsKey)
        } catch {
            print("Erro ao codificar favesAlbuns: \(error.localizedDescription)")
        }
    }

    static func removeFromFaves(_ album: Album) {
        var currentFavesList = getFaves()
        currentFavesList.removeAll { $0.id == album.id }
        do {
            let data = try JSONEncoder().encode(currentFavesList)
            UserDefaults.standard.set(data, forKey: favesAlbunsKey)
        } catch {
            print("Erro ao codificar favesAlbuns após remoção: \(error.localizedDescription)")
        }
    }

    static func isOnFavesList(_ album: Album) -> Bool {
        return getFaves().contains(album)
    }
}

