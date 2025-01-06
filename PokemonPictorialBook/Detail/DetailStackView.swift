//
//  DetailStackView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import UIKit
import RxSwift

/// DetailView의 subview
class DetailStackView: UIStackView {
    private let disposeBag = DisposeBag()
    
    private(set) lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private(set) lazy var typeLabel = detailLabel()
    
    private(set) lazy var heightLabel = detailLabel()
    
    private(set) lazy var weightLabel = detailLabel()
    
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
}
