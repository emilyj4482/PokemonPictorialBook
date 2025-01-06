//
//  MainViewModel.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation
import Moya
import RxMoya
import RxSwift
import RxCocoa

class MainViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let provider = MoyaProvider<PokemonAPI>()
    
    let pokemonList = PublishRelay<[PokemonResult]>()
    
    private var offset: Int = -20
    
    init() {
        fetchPokemonList()
    }
    
    func fetchPokemonList() {
        offset += 20
        
        provider.rx.request(.fetchURL(offset: offset))
            .map(PokemonList.self)
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
