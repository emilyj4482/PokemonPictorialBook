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
        
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubviews()
        layout()
        configure()
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
    
    func configure() {
        // temporary info
        let number = 54
        let name = "고라파덕"
        let type = "물"
        let height = 0.8
        let weight = 19.6
        
        pokemonImageView.image = .pokemonBall
        nameLabel.text = "No.\(number) \(name)"
        typeLabel.text = "타입 : \(type)"
        heightLabel.text = "키 : \(height)m"
        weightLabel.text = "몸무게 : \(weight)kg"
    }
}
