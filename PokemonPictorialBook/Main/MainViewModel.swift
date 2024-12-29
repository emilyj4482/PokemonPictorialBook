//
//  MainViewModel.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation
import RxSwift
import RxMoya

class MainViewModel {
    
    private let disposeBag = DisposeBag()
    private let networkManager = NetworkManager.shared
    
    let pokemonList = PublishSubject<[PokemonResult]>()
    let pokemonDetail = PublishSubject<Pokemon>()
    
    init() {
        fetchPokemonList()
        fetchPokemonDetail()
    }
    
    func fetchPokemonList() {
        networkManager.provider.request(.fetchURL(offset: 24)) { [weak self] result in
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
    
    func fetchPokemonDetail() {
        networkManager.provider.rx.request(.fetchPokemon(id: 1))
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(Pokemon.self, from: response.data)
                        self?.pokemonDetail.onNext(data)
                    } catch {
                        self?.pokemonDetail.onError(error)
                    }
                case .failure(let error):
                    self?.pokemonDetail.onError(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
