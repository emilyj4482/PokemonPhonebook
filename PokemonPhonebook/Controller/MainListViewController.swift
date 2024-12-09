//
//  ViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 08/12/2024.
//

import UIKit

class MainListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "친구 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
}

extension MainListViewController {
    @objc func addButtonTapped() {
        navigationController?.pushViewController(PhoneBookViewController(), animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: MainListViewController())
}
