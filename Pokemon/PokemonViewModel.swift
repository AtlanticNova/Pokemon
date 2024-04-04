//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Martinus Andika Novanawa on 04/04/24.
//

import SwiftUI

struct Pokemon: Identifiable, Decodable {
    let pokeID = UUID()
    
    let id: Int
    let name: String
    let imageUrl: String
    let type: String
    let description: String
    
    let attack: Int
    let defense: Int
    let height: Int
    let weight: Int
    
    var isFavorite = Bool()
    var isCaptured = Bool()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl
        case type
        case description
        case attack
        case defense
        case height
        case weight
    }
    
    var typeColor: Color {
        switch type {
        case "fire":
            return Color(.systemRed)
        case "poison":
            return Color(.systemGreen)
        case "water":
            return Color(.systemTeal)
        case "electric":
            return Color(.systemYellow)
        case "psychic":
            return Color(.systemPurple)
        case "normal":
            return Color(.systemOrange)
        case "ground":
            return Color(.systemBrown)
        case "flying":
            return Color(.systemBlue)
        case "fairy":
            return Color(.systemPink)
        default:
            return Color(.systemIndigo)
        }
    }
}

enum FetchError: Error {
    case badURL
    case badResponse
    case badData
}

class PokemonViewModel: ObservableObject {
    @Published var pokemon = [Pokemon]()
    
    init() {
        Task {
            pokemon = try await getPokemon()
        }
    }
    func getPokemon() async throws -> [Pokemon] {
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json") else { throw FetchError.badURL }
        
        let urlRequest = URLRequest(url:url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData }
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
        
        let maybePokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        return maybePokemonData
    }
    
    let MOCK_POKEMON = Pokemon(id: 0, name: "Bulbasaur", imageUrl: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334", type: "poision", description: "Bulbasaur can be seen napping in bright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays,\nthe seed grows progressively larger.", attack: 49, defense: 52, height: 10, weight: 98, isFavorite: true, isCaptured: true)
}

class PokemonData: ObservableObject {
    @Published var capturedPokemon: [Pokemon] = []
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
