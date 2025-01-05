//
//  MainView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit

class MainView: UIView {
    
    private lazy var pokemonBallImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .pokemonBall
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private(set) lazy var pokemonCollectionView: PokemonCollectionView = .init()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews([pokemonBallImageView, pokemonCollectionView])
    }
    
    private func layout() {
        pokemonBallImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.width.equalToSuperview().dividedBy(3)
            $0.height.equalTo(pokemonBallImageView.snp.width)
        }
        
        pokemonCollectionView.snp.makeConstraints {
            $0.top.equalTo(pokemonBallImageView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func updateCollectionViewDataSource(with items: [PokemonResult]) {
        pokemonCollectionView.updateDataSource(with: items)
    }
}
