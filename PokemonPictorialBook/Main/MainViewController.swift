//
//  ViewController.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 28/12/2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var containerView: MainView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addSubviews()
        layout()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addSubviews() {
        view.addSubviews([containerView])
    }

    private func layout() {
        view.backgroundColor = .mainRed
        
        let safeArea = view.safeAreaLayoutGuide
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
    }
}
