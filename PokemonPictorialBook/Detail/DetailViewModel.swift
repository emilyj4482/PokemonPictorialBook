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
    
    private let networkManager = NetworkManager.shared
    
    // 기본값 메타몽
    @Published var pokemonDetail: Pokemon = .init(
        id: 132,
        name: "ditto",
        types: [PokemonType(type: PokemonTypeName(name: "normal"))],
        height: 3,
        weight: 40
    )
    
    // Main에서 특정 포켓몬 url을 전달 받으면서 초기화
    init(_ urlString: String) {
        fetchPokemonDetail(urlString)
    }

    func fetchPokemonDetail(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        networkManager.fetch(url: url)
            .subscribe(
                onSuccess: { [weak self] (response: Pokemon) in
                    self?.pokemonDetail = response
                },
                onFailure: { error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}
