//
//  PokemonRepository.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 06/01/2025.
//

import Foundation
import Moya
import RxMoya
import RxSwift
import RxCocoa

// 참조된 속성을 사용하는 게 아니라, 단순히 함수만 사용할 것이므로 구조체로 선언한다.
struct PokemonRepository {
    private let provider = MoyaProvider<PokemonAPI>()
    private let networkManager = NetworkManager.shared
    
    func fetchPokemonList(offset: Int) -> Single<PokemonList> {
        return Single.create { observer in
            provider.rx.request(.fetchURL(offset: offset))
                .map(PokemonList.self)
                .subscribe(
                    onSuccess: {
                        return observer(.success($0))
                    }, onFailure: { error in
                        observer(.failure(error))
                    }
                )
        }
    }
    
    func fetchPokemonDetail(_ urlString: String) -> Single<PokemonDetail>{
        guard let url = URL(string: urlString) else {
            return Single.error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        
        return networkManager.fetch(url: url)
    }
}
