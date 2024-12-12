//
//  MainListViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 08/12/2024.
//

import UIKit

/// 메인 연락처 목록 화면 controller
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 연락처 개수가 0이면 blank view가 뜨도록 bool 값 전달
        containerView.reloadView(vm.phoneBooks.count == 0)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "연락처 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
    }
}

extension MainListViewController: MainListViewDelegate {
    // table view datasource에 연락처 개수 전달
    func getPhoneBookCount() -> Int {
        vm.phoneBooks.count
    }
    
    // table view datasource에 index번째 연락처 전달
    func getPhoneBook(with index: Int) -> PhoneBook {
        return vm.phoneBooks[index]
    }
    
    // table view delegate didSelectRowAt에서 호출되는 함수
    // 연락처 조회 모드로 PhoneBookView로 이동 : Mode 값 .read, 조회하는 PhoneBook 정보 전달하고 이동
    func pushPhoneBookView(with index: Int) {
        let vc = PhoneBookViewController()
        vc.mode = .read
        vc.phoneBook = vm.phoneBooks[index]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 우측 상단 추가 bar button 탭했을 때 호출되는 함수
    // 연락처 추가 모드로 PhoneBookView로 이동 : Mode 값 .create
    @objc func addButtonTapped() {
        let vc = PhoneBookViewController()
        vc.mode = .create
        navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: MainListViewController())
}
