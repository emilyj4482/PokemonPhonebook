//
//  PhoneBookViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 08/12/2024.
//

import UIKit

class PhoneBookViewController: UIViewController {
    private let vm: PhoneBookViewModel = .init()
    private lazy var containerView: PhoneBookView = .init(mode: mode)
    
    var mode: Mode = .read
    var phoneBook: PhoneBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        layout()
        setDelegate()
        configureContainerView()
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: mode.buttonTitle, style: .plain, target: self, action: #selector(barButtonTapped))
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
    
    private func configureContainerView() {
        switch mode {
        case .read:
            guard let phoneBook = phoneBook else { return }
            navigationItem.title = phoneBook.name
            containerView.bind(phoneBook)
        case .create:
            navigationItem.title = "연락처 추가"
            fetchPokemonImage(1)
        case .edit:
            return
        }
    }
}

extension PhoneBookViewController: PhoneBookViewDelegate {
    func fetchPokemonImage(_ id: Int) {
        vm.fetchPokemon(id)
    }
    
    @objc func barButtonTapped() {
        switch mode {
        case .read:
            mode = .edit
            containerView.mode = mode
            navigationItem.rightBarButtonItem?.title = mode.buttonTitle
            guard let phoneBook = phoneBook else { return }
            containerView.bindTextFields(phoneBook)
        case .create:
            // TODO: 저장되었습니다 alert
            navigationController?.popViewController(animated: true)
        case .edit:
            // TODO: 저장되었습니다 alert
            mode = .read
            containerView.mode = mode
            navigationItem.rightBarButtonItem?.title = mode.buttonTitle
        }
    }
}

#Preview {
    UINavigationController(rootViewController: PhoneBookViewController())
}
