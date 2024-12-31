//
//  +Double.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 31/12/2024.
//

import Foundation

// 포켓몬의 키/몸무게 값을 m/kg으로 표시하기 위해 API 통신 응답 데이터보다 0.1배 한 뒤 소수점 한자리까지 표시되는 문자열로 변환
extension Double {
    var converted: String {
        String(format: "%.1f", self * 0.1)
    }
}
