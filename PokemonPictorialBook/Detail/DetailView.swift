//
//  DetailView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 12/01/2025.
//

import SwiftUI
import RxSwift
import Kingfisher

struct DetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let disposeBag = DisposeBag()
    
    @ObservedObject var vm: DetailViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    VStack(spacing: 30) {
                        if let imageURL = vm.imageURL {
                            KFImage(imageURL)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width / 3)
                        } else {
                            Image(.pokemonBall)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width / 3)
                        }
                        
                        Text(vm.pokemonPresent?.nameString ?? "")
                            .font(.title)
                            .bold()
                        
                        VStack(spacing: 8) {
                            Text(vm.pokemonPresent?.typeString ?? "")
                            Text(vm.pokemonPresent?.heightString ?? "")
                            Text(vm.pokemonPresent?.weightString ?? "")
                        }
                        .font(.title3)
                    }
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
            
            .onAppear {
                vm.didRequest.accept(())
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}
