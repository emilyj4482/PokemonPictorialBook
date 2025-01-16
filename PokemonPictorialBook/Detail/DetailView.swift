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
    
    private let disposeBag = DisposeBag()
    
    @StateObject var vm: DetailViewModel
    
    @State var imageURL: URL?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(spacing: 30) {
                    KFImage(imageURL)
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
        .onAppear {
            vm.fetchedRelay
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onNext: {
                        guard let url = URL(string: ImageURL.pokemon(id: vm.pokemonDetail.id).urlString) else { return }
                        imageURL = url
                    }
                )
                .disposed(by: disposeBag)
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}
