//
//  DetailView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 12/01/2025.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(spacing: 30) {
                    Image(.pokemonBall)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 3)
                    
                    Text("No.\(vm.pokemonDetail.id) \(vm.pokemonDetail.translatedName)")
                        .font(.title)
                        .bold()
                    
                    VStack(spacing: 8) {
                        Text("타입 : \(vm.pokemonDetail.types.map { $0.type.translatedType }.joined(separator: ", "))")
                        Text("키 : \(vm.pokemonDetail.height.converted)m")
                        Text("몸무게 : \(vm.pokemonDetail.weight.converted)kg")
                    }
                    .font(.title3)
                }
                .padding(.vertical, 50)
                .frame(maxWidth: .infinity)
                .background(Color(uiColor: .darkRed))
                .clipShape(.rect(cornerRadius: 15))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .foregroundStyle(.white)
            .background(Color(uiColor: .mainRed))
        }
    }
}

#Preview {
    DetailView(vm: DetailViewModel(""))
}
