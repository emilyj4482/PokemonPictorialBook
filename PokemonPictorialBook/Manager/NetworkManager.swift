//
//  NetworkManager.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation
import Moya
import Alamofire
import RxSwift

class NetworkManager {
    static let shared = NetworkManager()
    
    let provider = MoyaProvider<PokemonAPI>()
    
    private init() {}
    
    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { observer in
            AF.request(url).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observer(.success(value))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

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
                .requestParameters(parameters: ["limit": "20", "offset": "\(offset)"], encoding: URLEncoding.queryString)
        case .fetchPokemon:
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
