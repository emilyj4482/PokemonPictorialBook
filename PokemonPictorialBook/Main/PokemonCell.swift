//
//  PokemonCell.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    static let identifier = "PokemonCell"
    
    private(set) lazy var pokemonImageView: UIImageView = {
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
}
