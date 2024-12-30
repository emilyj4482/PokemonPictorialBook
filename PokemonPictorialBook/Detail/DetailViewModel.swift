//
//  DetailViewModel.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import Foundation
import RxSwift

class DetailViewModel {
    
    private let disposeBag = DisposeBag()
    private let networkManager = NetworkManager.shared
    
    let pokemonDetail = PublishSubject<Pokemon>()
    
    init(_ urlString: String) {
        fetchPokemonDetail(urlString)
    }
    
    // func fetchPokemonDetail(_ id: String) {
    func fetchPokemonDetail(_ urlString: String) {
        // guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
        guard let url = URL(string: urlString) else {
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
