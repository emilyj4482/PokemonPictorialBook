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
import SwiftUI

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
                    self?.containerView.hideIndicator()
                    self?.pokemons.append(contentsOf: pokemons)
                }
            )
            .disposed(by: disposeBag)
        
        containerView.pokemonCollectionView.rx.itemSelected
            .subscribe(
                onNext: { [weak self] indexPath in
                    guard
                        let self = self,
                        let url = URL(string: pokemons[indexPath.item].url)
                    else { return }
                    let detailViewModel = DetailViewModel(id: pokemons[indexPath.item].pokemonId, url: url, repository: vm.repository)
                    let detailView = UIHostingController(rootView: DetailView(vm: detailViewModel))
                    navigationController?.pushViewController(detailView, animated: true)
                }
            )
            .disposed(by: disposeBag)
        
        containerView.pokemonCollectionView.rx.didEndDecelerating
            .subscribe(
                onNext: { [weak self] in
                    guard let scrollView = self?.containerView.pokemonCollectionView else { return }
                    if scrollView.contentSize.height - scrollView.contentOffset.y == scrollView.visibleSize.height {
                        self?.containerView.showIndicator()
                        self?.vm.fetchPokemonList()
                    }
                }
            )
            .disposed(by: disposeBag)
        
        vm.errorRelay
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.showAlert()
            }
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    private func showAlert() {
        let alert = UIAlertController(title: "오류 발생", message: "포켓몬 데이터를 불러오는 도중 오류가 발생했습니다. 다음에 다시 시도해주세요.", preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
}
