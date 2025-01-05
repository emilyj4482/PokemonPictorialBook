//
//  PokemonURL.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation

struct PokemonURL: Decodable {
    let results: [PokemonResult]
}

struct PokemonResult: Decodable, Hashable {
    let name: String
    let url: String
    
    var pokemonId: String {
        guard let id = url.split(separator: "/").last else { return "" }
        return String(id)
    }
}
