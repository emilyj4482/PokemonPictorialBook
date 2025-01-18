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
    
    @Published var pokemonPresent: PokemonPresent = Pokemon.ditto.toPresent
    
    @Published var imageURL: URL?
    
    let didRequest = PublishRelay<Void>()
    
    init(_ url: URL, networkManager: NetworkManager = .shared) {
        didRequest
            .flatMap {
                networkManager.fetch(url: url)
            }
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (pokemon: Pokemon) in
                    self?.pokemonPresent = pokemon.toPresent
                    self?.imageURL = URL(string: ImageURL.pokemon(id: pokemon.id).urlString)
                }
            )
            .disposed(by: disposeBag)
    }
}
