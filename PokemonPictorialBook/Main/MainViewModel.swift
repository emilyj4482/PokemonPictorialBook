//
//  MainViewModel.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation
import RxSwift
import Moya

class MainViewModel {
    
    private let provider = MoyaProvider<PokemonAPI>()
    
    let pokemonList = PublishSubject<[PokemonResult]>()
    
    init() {
        fetchPokemonList()
    }
    
    func fetchPokemonList() {
        provider.request(.fetchURL(offset: 24)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(PokemonURL.self, from: response.data)
                    self?.pokemonList.onNext(data.results)
                } catch {
                    self?.pokemonList.onError(NetworkError.decodingFailed)
                }
            case .failure(let error):
                self?.pokemonList.onError(error)
            }
        }
    }
}
