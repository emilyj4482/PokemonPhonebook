//
//  ViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 08/12/2024.
//

import UIKit

class MainListViewController: UIViewController {
    private let vm: MainListViewModel = .init()
    private lazy var containerView: MainListView = .init()
    
    override func loadView() {
        view = containerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        containerView.delegate = self
    }
    
    private func setNavigationBar() {
        navigationItem.title = "친구 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
    }
}

extension MainListViewController: MainListViewDelegate {
    func getPhoneBookCount() -> Int {
        vm.phoneBooks.count
    }
    
    func getPhoneBook(with index: Int) -> PhoneBook {
        return vm.phoneBooks[index]
    }
    
    func pushPhoneBookView(with index: Int) {
        let vc = PhoneBookViewController()
        vc.mode = .read
        vc.phoneBook = vm.phoneBooks[index]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addButtonTapped() {
        let vc = PhoneBookViewController()
        vc.mode = .create
        navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: MainListViewController())
}
