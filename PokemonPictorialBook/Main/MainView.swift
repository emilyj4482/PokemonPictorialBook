//
//  MainView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit

/// Main 화면의 container view
class MainView: UIView {
    
    private lazy var pokemonBallImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .pokemonBall
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private(set) lazy var pokemonCollectionView: PokemonCollectionView = .init()
    
    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.color = .gray
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
        return indicator
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews([pokemonBallImageView, pokemonCollectionView, loadingIndicatorView])
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
        
        loadingIndicatorView.snp.makeConstraints {
            $0.center.equalTo(pokemonCollectionView)
        }
    }
    
    func updateCollectionViewDataSource(with items: [PokemonResult]) {
        pokemonCollectionView.updateDataSource(with: items)
    }
    
    func showIndicator() {
        loadingIndicatorView.startAnimating()
    }
    
    func hideIndicator() {
        loadingIndicatorView.stopAnimating()
    }
}
