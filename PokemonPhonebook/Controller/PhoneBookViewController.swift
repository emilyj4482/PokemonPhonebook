//
//  PhoneBookViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 08/12/2024.
//

import UIKit

class PhoneBookViewController: UIViewController {
    private lazy var containerView: PhoneBookView = .init()
    
    override func loadView() {
        view = containerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "연락처 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(confirmButtonTapped))
    }
    
}

extension PhoneBookViewController {
    @objc func confirmButtonTapped() {
        print("tapped")
    }
}
