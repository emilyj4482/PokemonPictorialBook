//
//  MainViewModel.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import Foundation
import RxSwift

class MainViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let repository = PokemonRepository()
    
    // let pokemonList = PublishRelay<[PokemonResult]>()
    
    private var offset: Int = -20
    
    init() {
        
    }
    
    func transform(_ input: Input) -> Output {
        offset += 20
        
        let pokemonList = input.load
            .withUnretained(self)   // (object, value) 튜플 매핑 > self obj : vm, value : input.load
            .flatMapLatest { [unowned self] owner, _ in    // 보통 self obj를 owner라고 표시함
                // flatMapLatest : 맨 마지막 이벤트만 받음. return Observable의 형태가 되어야 함
                owner.repository.fetchPokemonList(offset: offset)
            }
            .map { $0.results }
            .asObservable()
        
        return .init(pokemonList: pokemonList)
    }
    
}

extension MainViewModel {
    // VC로부터 값이 입력될 때 / 이벤트가 발생했을 때 / 트리거가 작동했을 때 -> VM
    struct Input {
        let load: Observable<Void>
    }
    
    
    // VM을 거치고 나온 결과값 -> VC
    struct Output {
        let pokemonList: Observable<[PokemonResult]>
    }
}
