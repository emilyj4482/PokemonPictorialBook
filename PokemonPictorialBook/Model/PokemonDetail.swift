//
//  PokemonDetail.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let height: Double
    let weight: Double
    
    var translatedName: String {
        PokemonNameTranslator.getKoreanName(for: name)
    }
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
