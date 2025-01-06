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
    
    private let networkManager = NetworkManager.shared
    
    let pokemonDetail = PublishRelay<Pokemon>()
    
    // Main에서 특정 포켓몬 url을 전달 받으면서 초기화. 기본값으로 메타몽 url
    init(_ urlString: String = "https://pokeapi.co/api/v2/pokemon/132") {
        fetchPokemonDetail(urlString)
    }

    func fetchPokemonDetail(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        networkManager.fetch(url: url)
            .subscribe(
                onSuccess: { [weak self] (response: Pokemon) in
                    self?.pokemonDetail.accept(response)
                },
                onFailure: { error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}
