//
//  PokemonPresent.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 18/01/2025.
//

import Foundation

struct PokemonPresent {
    let nameString: String
    let typeString: String
    let heightString: String
    let weightString: String
}

extension Pokemon {
    var toPresent: PokemonPresent {
        return PokemonPresent(
            nameString: "No.\(self.id) \(self.translatedName)",
            typeString: "타입 : \(self.types.map { $0.type.translatedType }.joined(separator: ", "))",
            heightString: "키 : \(self.height.converted)m",
            weightString: "몸무게 : \(self.weight.converted)kg"
        )
    }
}
