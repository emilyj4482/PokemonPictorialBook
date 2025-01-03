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
        vm.pokemonList
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] pokemons in
                    self?.containerView.updateCollectionViewDataSource(with: pokemons)
                    self?.pokemons.append(contentsOf: pokemons)
                },
                onError: { error in
                    print(error)
                }
            )
            .disposed(by: disposeBag)
        
        containerView.pokemonCollectionView.rx.itemSelected
            .subscribe(
                onNext: { [weak self] indexPath in
                    guard let self = self else { return }
                    let vc = DetailViewController(vm: .init(pokemons[indexPath.item].url))
                    navigationController?.pushViewController(vc, animated: true)
                }
            )
            .disposed(by: disposeBag)
        
        containerView.pokemonCollectionView.rx.didEndDecelerating
            .subscribe(
                onNext: { [weak self] in
                    guard let scrollView = self?.containerView.pokemonCollectionView else { return }
                    if scrollView.contentSize.height - scrollView.contentOffset.y == scrollView.visibleSize.height {
                        self?.vm.fetchPokemonList()
                    }
                }
            )
            .disposed(by: disposeBag)
    }
}
