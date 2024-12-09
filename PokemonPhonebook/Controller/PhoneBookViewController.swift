//
//  PhoneBookViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 08/12/2024.
//

import UIKit

class PhoneBookViewController: UIViewController {
    
    private let vm: PhoneBookViewModel = .init()
    
    private lazy var containerView: PhoneBookView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        layout()
        setDelegate()
        fetchPokemonImage(1)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "연락처 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(confirmButtonTapped))
    }
    
    private func layout() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setDelegate() {
        vm.delegate = containerView
        containerView.delegate = self
    }
}

extension PhoneBookViewController: RandomImageDelegate {
    func fetchPokemonImage(_ id: Int) {
        vm.fetchPokemon(id)
    }
    
    @objc func confirmButtonTapped() {
        print("tapped")
    }
}

#Preview {
    UINavigationController(rootViewController: PhoneBookViewController())
}
