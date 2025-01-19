//
//  PokemonAPI.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import Foundation
import Moya

/// Moya를 활용한 네트워크 통신 환경 구축 - MainViewModel에서 사용
enum PokemonAPI {
    case fetchPokemons(offset: Int)
    case fetchKoreanName(id: String)
}

extension PokemonAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://pokeapi.co/api/v2")!
    }
    
    var path: String {
        switch self {
        case .fetchPokemons:
            return "/pokemon"
        case .fetchKoreanName(let id):
            return "/pokemon-species/\(id)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchPokemons(let offset):
                .requestParameters(parameters: ["limit": "20", "offset": "\(offset)"], encoding: URLEncoding.queryString)
        case .fetchKoreanName:
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
