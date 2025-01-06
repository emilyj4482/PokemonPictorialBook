//
//  ImageURL.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 06/01/2025.
//

import Foundation

/// main view의 컬렉션 뷰 셀(PokemonCell)과 detail stack view에서 Kingfisher를 사용해서 이미지 configuring할 때 사용하는 url 재사용
enum ImageURL {
    case pokemon(id: any Comparable)
    
    var urlString: String {
        switch self {
        case .pokemon(let id): "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        }
    }
}
