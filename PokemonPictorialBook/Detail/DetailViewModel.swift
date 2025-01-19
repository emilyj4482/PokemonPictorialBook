//
//  DetailViewModel.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ObservableObject {
    
    private let disposeBag = DisposeBag()
    
    @Published var pokemonPresent: PokemonPresent?
    
    @Published var imageURL: URL?
    
    let didRequest = PublishRelay<Void>()
    
    init(id: String, url: URL, repository: PokemonRepositoryType) {
        didRequest
            .flatMap {
                Observable
                    .combineLatest(repository.fetchPokemonDetail(url), repository.fetchPokemonKoreanName(id))
            }
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] (pokemon: Pokemon, species: PokemonSpecies) in
                guard
                    let self = self,
                    let koreanName = species.names.first(where: { $0.language.name == "ko" })?.name
                else { return }
                
                let present = PokemonPresent(
                    nameString: "No.\(pokemon.id) \(koreanName)",
                    typeString: "타입 : \(pokemon.types.map { $0.type.translatedType }.joined(separator: ", "))",
                    heightString: "키 : \(pokemon.height.converted)m",
                    weightString: "몸무게 : \(pokemon.weight.converted)kg"
                )
                pokemonPresent = present
                imageURL = URL(string: ImageURL.pokemon(id: pokemon.id).urlString)
            }
            .disposed(by: disposeBag)
    }
}
