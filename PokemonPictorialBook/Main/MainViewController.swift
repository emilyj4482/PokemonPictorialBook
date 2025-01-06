//
//  MainViewController.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let vm: MainViewModel = .init()
    
    private var pokemons = [PokemonResult]()
    
    private lazy var containerView: MainView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addSubviews() {
        view.addSubviews([containerView])
    }

    private func layout() {
        view.backgroundColor = .mainRed
        
        let safeArea = view.safeAreaLayoutGuide
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
    }
    
    private func bind() {
        let load = self.rx.viewWillAppear
        let input = MainViewModel.Input(load: load)
        let output = vm.transform(input)
        
        output.pokemonList
            .bind(to: containerView.pokemonCollectionView.rx.items(cellIdentifier: PokemonCell.identifier, cellType: PokemonCell.self)) { index, pokemon, cell in
                cell.configure(pokemon)
            }
            .disposed(by: disposeBag)

        containerView.pokemonCollectionView.rx.modelSelected(PokemonResult.self)
            .withUnretained(self)
            .subscribe(
                onNext: { [weak self] owner, pokemon in
                    let vc = DetailViewController(vm: .init(pokemon.url))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            )
            .disposed(by: disposeBag)
        
        containerView.pokemonCollectionView.rx.didEndDecelerating
            .subscribe(
                onNext: { [weak self] in
                    guard let scrollView = self?.containerView.pokemonCollectionView else { return }
                    if scrollView.contentSize.height - scrollView.contentOffset.y == scrollView.visibleSize.height {
                        //self?.vm.fetchPokemonList()
                    }
                }
            )
            .disposed(by: disposeBag)
    }
}
