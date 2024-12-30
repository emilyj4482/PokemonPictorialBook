//
//  PokemonCollectionView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit
import Kingfisher

class PokemonCell: UICollectionViewCell {
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
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.pokemonId).png") else { return }
        pokemonImageView.kf.setImage(with: url)
    }
}
