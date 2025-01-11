//
//  DetailView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 12/01/2025.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                    .frame(height: 50)
                
                VStack(spacing: 30) {
                    Image(.pokemonBall)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 3)
                    
                    Text("No.25 피카츄")
                        .font(.title2)
                    
                    VStack {
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color(uiColor: .darkRed))
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
            }
            .padding(.horizontal, 32)
            .foregroundStyle(.white)
            .background(Color(uiColor: .mainRed))
        }
    }
}

#Preview {
    DetailView()
}
