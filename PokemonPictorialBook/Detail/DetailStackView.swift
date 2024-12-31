//
//  DetailStackView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import UIKit

class DetailStackView: UIStackView {
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var typeLabel = detailLabel()
    
    private lazy var heightLabel = detailLabel()
    
    private lazy var weightLabel = detailLabel()
    
    private func detailLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubviews()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addArrangedSubviews() {
        addArrangedSubviews([pokemonImageView, nameLabel, typeLabel, heightLabel, weightLabel])
    }
    
    private func layout() {
        backgroundColor = .darkRed
        layer.cornerRadius = 15
        axis = .vertical
        spacing = 8
        distribution = .fill
        
        pokemonImageView.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(2)
        }
    }
    
    func configure(_ pokemon: Pokemon) {
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.id).png") else { return }
        
        pokemonImageView.kf.setImage(with: url)
        
        nameLabel.text = "No.\(pokemon.id) \(pokemon.translatedName)"
        typeLabel.text = "타입 : \(pokemon.types[0].type.translatedType)"
        heightLabel.text = "키 : \(pokemon.height * 0.1)m"
        weightLabel.text = "몸무게 : \(pokemon.weight * 0.1)kg"
        
        // type이 2개 이상일 경우
        if pokemon.types.count > 1 {
            typeLabel.text?.append(", \(pokemon.types[1].type.translatedType)")
        }
    }
}
