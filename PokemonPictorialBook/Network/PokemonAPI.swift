//
//  PokemonAPI.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import Foundation
import Moya

enum PokemonAPI {
    case fetchURL(offset: Int)
    case fetchPokemon(id: Int)
}

extension PokemonAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://pokeapi.co/api/v2")!
    }
    
    var path: String {
        switch self {
        case .fetchURL:
            return "/pokemon"
        case .fetchPokemon(let id):
            return "/pokemon/\(id)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchURL(let offset):
                .requestParameters(parameters: ["limit": "21", "offset": "\(offset)"], encoding: URLEncoding.queryString)
        case .fetchPokemon:
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
