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
    
    private let disposeBag = DisposeBag()
    private let networkManager = NetworkManager.shared
    private let provider = MoyaProvider<PokemonAPI>()
    
    let pokemonList = PublishSubject<[PokemonResult]>()
    let pokemonDetail = PublishSubject<Pokemon>()
    
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
                    self?.pokemonList.onError(error)
                }
            case .failure(let error):
                self?.pokemonList.onError(error)
            }
        }
    }
    
    func fetchPokemonDetail(_ id: String) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            pokemonDetail.onError(NetworkError.invalidURL)
            return
        }
        
        networkManager.fetch(url: url)
            .subscribe(
                onSuccess: { [weak self] (response: Pokemon) in
                    self?.pokemonDetail.onNext(response)
                },
                onFailure: { [weak self] error in
                    self?.pokemonDetail.onError(error)
                }
            )
            .disposed(by: disposeBag)
    }
}
