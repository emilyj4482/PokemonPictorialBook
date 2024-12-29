//
//  +UIStackView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 29/12/2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
