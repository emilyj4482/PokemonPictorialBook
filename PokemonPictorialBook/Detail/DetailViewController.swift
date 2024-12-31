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
    
    var vm: DetailViewModel
    
    private lazy var containerView: DetailView = .init()

    init(vm: DetailViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func bind() {
        vm.pokemonDetail
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] pokemon in
                    self?.containerView.configure(pokemon)
                },
                onError:  {
                    print($0)
                }
            )
            .disposed(by: disposeBag)
    }
}
