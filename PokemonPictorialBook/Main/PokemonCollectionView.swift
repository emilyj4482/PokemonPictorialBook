//
//  PokemonCollectionView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NukeExtensions

/// MainView의 subview
class PokemonCollectionView: UICollectionView {
    
    private let disposeBag = DisposeBag()
    
    private let sectionsRelay = BehaviorRelay<[Section]>(value: [Section(header: "main", items: [])])
    
    private lazy var rxDataSource = RxCollectionViewSectionedReloadDataSource<Section> { datasource, collectionView, indexPath, item in
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell,
            let imageURL = URL(string: ImageURL.pokemon(id: item.pokemonId).urlString)
        else { return UICollectionViewCell() }
        
        NukeExtensions.loadImage(with: imageURL, into: cell.pokemonImageView)
        
        return cell
    }
    
    init() {
        let layout: UICollectionViewCompositionalLayout = {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
            
            let section = NSCollectionLayoutSection(group: group)
            
            return UICollectionViewCompositionalLayout(section: section)
        }()
        
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .darkRed
        
        register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
    }
    
    private func bind() {
        sectionsRelay
            .bind(to: rx.items(dataSource: rxDataSource))
            .disposed(by: disposeBag)
    }

    func updateDataSource(with items: [PokemonResult]) {
        appendItems(items, toSection: 0)
    }
    
    private func appendItems(_ items: [PokemonResult], toSection index: Int) {
        var sections = sectionsRelay.value
        guard index < sections.count else { return }
        
        var section = sections[index]
        section.items.append(contentsOf: items)
        sections[index] = section
        
        sectionsRelay.accept(sections)
    }
}
