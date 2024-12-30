//
//  NetworkError.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            "[Error] URL invalid"
        }
    }
}
