//
//  PokemonCell.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit
import RxSwift

class PokemonCell: UICollectionViewCell {
    private let disposeBag = DisposeBag()
    
    static let identifier = "PokemonCell"
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = .pokemonBall
    }
    
    private func addSubviews() {
        addSubviews([pokemonImageView])
    }
    
    private func layout() {
        backgroundColor = .cellBackground
        layer.cornerRadius = 10
        
        pokemonImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(_ pokemon: PokemonResult) {
        pokemonImageView.rx.loadImage(id: pokemon.id)
            .observe(on: MainScheduler.instance)
            .bind(to: pokemonImageView.rx.image)
            .disposed(by: disposeBag)
    }
}
