//
//  DetailViewModel.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let repository = PokemonRepository()
    
    private let urlString: String
    
    init(_ urlString: String) {
        self.urlString = urlString
    }

    func transform(_ input: Input) -> Output {
        let pokemonDetail = input.load
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.repository.fetchPokemonDetail(owner.urlString)
            }
            .asObservable()
        
        return .init(pokemonDetail: pokemonDetail)
    }
}

extension DetailViewModel {
    struct Input {
        let load: Observable<Void>
    }
    
    struct Output {
        let pokemonDetail: Observable<PokemonDetail>
    }
}
