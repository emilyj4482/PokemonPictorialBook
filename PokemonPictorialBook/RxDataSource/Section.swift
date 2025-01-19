//
//  Section.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 19/01/2025.
//

import Foundation
import RxDataSources

struct Section {
    var header: String
    var items: [Item]
}

extension Section: SectionModelType {
    typealias Item = PokemonResult
    
    init(original: Section, items: [PokemonResult]) {
        self = original
        self.items = items
    }
}
