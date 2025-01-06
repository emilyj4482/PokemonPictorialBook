//
//  PokemonList.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation

struct PokemonList: Decodable {
    let results: [PokemonResult]
}

struct PokemonResult: Decodable, Hashable {
    let name: String
    let url: String
    
    var id: Int {
        guard let id = url.split(separator: "/").last else { return 132 }
        return Int(id) ?? 132
    }
}
