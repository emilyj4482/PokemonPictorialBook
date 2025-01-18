//
//  Pokemon.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let height: Double
    let weight: Double
    
    var translatedName: String {
        PokemonNameTranslator.getKoreanName(for: name)
    }
    
    static let ditto: Pokemon = .init(
        id: 132,
        name: "ditto",
        types: [PokemonType(type: PokemonTypeName(name: "normal"))],
        height: 3,
        weight: 40
    )
}

struct PokemonType: Decodable {
    let type: PokemonTypeName
}

struct PokemonTypeName: Decodable {
    let name: String
    
    var translatedType: String {
        PokemonTypeTranslator(rawValue: name)?.toKorean ?? name
    }
}
