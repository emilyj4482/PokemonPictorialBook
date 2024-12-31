//
//  PokemonCollectionView.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 30/12/2024.
//

import UIKit

class PokemonCollectionView: UICollectionView {
    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, PokemonResult> = {
        return UICollectionViewDiffableDataSource(collectionView: self) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else { return UICollectionViewCell() }
            
            cell.configure(itemIdentifier)
            
            return cell
        }
    }()
    
    private var snapshot = NSDiffableDataSourceSnapshot<Section, PokemonResult>()
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .darkRed
        
        register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)

        dataSource = diffableDataSource
        snapshot.appendSections([.main])
    }
    
    func updateDataSource(with items: [PokemonResult]) {
        snapshot.appendItems(items, toSection: .main)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

enum Section: CaseIterable {
    case main
}
