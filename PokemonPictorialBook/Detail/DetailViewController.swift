//
//  DetailViewController.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var vm: DetailViewModel = .init("https://pokeapi.co/api/v2/pokemon/132")
    
    private lazy var containerView: DetailView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
        
        vm.pokemonDetail
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: {
                    print($0)
                },
                onError:  {
                    print($0)
                }
            )
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func addSubviews() {
        view.addSubviews([containerView])
    }

    private func layout() {
        view.backgroundColor = .mainRed
        
        let safeArea = view.safeAreaLayoutGuide
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(safeArea).offset(8)
            $0.height.equalTo(safeArea).dividedBy(1.7)
        }
    }
}
