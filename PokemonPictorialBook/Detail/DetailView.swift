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
                VStack(spacing: 30) {
                    Image(.pokemonBall)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 3)
                    
                    Text("No.25 피카츄")
                        .font(.title)
                        .bold()
                    
                    VStack(spacing: 8) {
                        Text("타입 : 전기")
                        Text("키 : 0.4m")
                        Text("몸무게 : 6.0kg")
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
    DetailView()
}
