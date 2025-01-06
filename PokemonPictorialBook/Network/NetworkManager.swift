//
//  NetworkManager.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation
import Alamofire
import RxSwift

/// Alamofire를 활용한 네트워크 통신 구현 - DetailViewModel에서 의존
class NetworkManager {
    static let shared = NetworkManager()
    
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
