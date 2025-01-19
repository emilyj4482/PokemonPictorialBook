//
//  PokemonRepository.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 19/01/2025.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol PokemonRepositoryType {
    func fetchPokemonList(_ offset: Int) -> Single<PokemonURL>
    func fetchPokemonDetail(_ url: URL) -> Observable<Pokemon>
    func fetchPokemonKoreanName(_ id: String) -> Observable<PokemonSpecies>
}

class PokemonRepository: PokemonRepositoryType {
    
    private let disposeBag = DisposeBag()
    
    private let networkManager = NetworkManager.shared
    private let provider = MoyaProvider<PokemonAPI>()
    
    func fetchPokemonList(_ offset: Int) -> Single<PokemonURL> {
        return provider.rx.request(.fetchPokemons(offset: offset))
            .map(PokemonURL.self)
    }
    
    func fetchPokemonDetail(_ url: URL) -> Observable<Pokemon> {
        return networkManager.fetch(url: url)
            .asObservable()
    }
    
    func fetchPokemonKoreanName(_ id: String) -> Observable<PokemonSpecies> {
        return provider.rx.request(.fetchKoreanName(id: id))
            .map(PokemonSpecies.self)
            .asObservable()
    }
}
