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
        let load = self.rx.viewWillAppear
        let input = DetailViewModel.Input(load: load)
        let output = vm.transform(input)
        
        // share : 여러번 사용할 observable에 대해 매번 새로 생성하지 않게 하는 코드
        let pokemonDetail = output.pokemonDetail.share()
        
        pokemonDetail
            .withUnretained(self)
            .flatMapLatest { owner, pokemon in
                owner.containerView.detailStackView.pokemonImageView.rx.loadImage(id: pokemon.id)
            }
            .observe(on: MainScheduler.instance)
            .bind(to: containerView.detailStackView.pokemonImageView.rx.image)
            .disposed(by: disposeBag)
        
        pokemonDetail
            .map { "No. \($0.id) \($0.translatedName)" }
            .bind(to: containerView.detailStackView.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        pokemonDetail
            .map { $0.types }
            .map { $0.map { $0.type.translatedType }.joined(separator: ", ") }
            .map { "타입 : \($0)" }
            .bind(to: containerView.detailStackView.typeLabel.rx.text)
            .disposed(by: disposeBag)
        
        pokemonDetail
            .map { $0.height.converted }
            .map { "키 : \($0)m" }
            .bind(to: containerView.detailStackView.heightLabel.rx.text)
            .disposed(by: disposeBag)
        
        pokemonDetail
            .map { $0.weight.converted }
            .map { "몸무게 : \($0)kg" }
            .bind(to: containerView.detailStackView.weightLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
