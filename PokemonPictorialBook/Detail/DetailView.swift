//
//  DetailView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit

/// Detail 화면의 container view
class DetailView: UIView {
    
    private lazy var detailStackView: DetailStackView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews([detailStackView])
    }
    
    private func layout() {
        backgroundColor = .darkRed
        layer.cornerRadius = 15
        
        detailStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(48)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    func configure(_ pokemon: Pokemon) {
        detailStackView.configure(pokemon)
    }
}
