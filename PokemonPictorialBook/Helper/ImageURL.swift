//
//  ImageURL.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 06/01/2025.
//

import Foundation

enum ImageURL {
    case pokemon(id: any Comparable)
    
    var urlString: String {
        switch self {
        case .pokemon(let id): "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        }
    }
}
