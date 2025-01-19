//
//  MainViewModel.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    private let disposeBag = DisposeBag()
    
    let repository: PokemonRepositoryType
    
    let pokemonList = PublishRelay<[PokemonResult]>()
    
    private var offset: Int = -20
    
    init(repository: PokemonRepositoryType = PokemonRepository()) {
        self.repository = repository
        fetchPokemonList()
    }
    
    func fetchPokemonList() {
        offset += 20
        
        repository.fetchPokemonList(offset)
            .subscribe(
                onSuccess: { [weak self] response in
                    self?.pokemonList.accept(response.results)
                },
                onFailure: { error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}
