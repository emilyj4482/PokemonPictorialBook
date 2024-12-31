//
//  NetworkError.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            "[Error] URL invalid"
        case .decodingFailed:
            "[Error] Decoding failed"
        }
    }
}
