//
//  DetailView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit

class DetailView: UIView {
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews([pokemonImageView, nameLabel, typeLabel, heightLabel, weightLabel])
    }
    
    private func layout() {
        backgroundColor = .darkRed
        layer.cornerRadius = 15
        
        pokemonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.height.equalToSuperview().dividedBy(2)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(pokemonImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        heightLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        weightLabel.snp.makeConstraints {
            $0.top.equalTo(heightLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
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
