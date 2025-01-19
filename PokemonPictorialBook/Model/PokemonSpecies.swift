//
//  PokemonSpecies.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 19/01/2025.
//

import Foundation

struct PokemonSpecies: Decodable {
    var names: [PokemonName]
}

struct PokemonName: Decodable {
    let name: String
    let language: Language
}

struct Language: Decodable {
    let name: String
    let url: String
}
