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

struct PokemonResult: Decodable {
    let name: String
    let url: String
}
