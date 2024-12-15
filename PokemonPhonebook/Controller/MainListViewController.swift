//
//  MainListViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 08/12/2024.
//

import UIKit

/// 메인 연락처 목록 화면 controller
class MainListViewController: UIViewController {
    private let coreDataRepository: CoreDataRepository = .init()
    private lazy var containerView: MainListView = .init()
    
    override func loadView() {
        view = containerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.delegate = self
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataRepository.fetchData()
        containerView.reloadView(coreDataRepository.phoneBooks.count == 0)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "연락처 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
    }
}

extension MainListViewController: MainListViewDelegate {
    func getPhoneBookCount() -> Int {
        coreDataRepository.phoneBooks.count
    }

    func getPhoneBook(with index: Int) -> PhoneBookEntity {
        return coreDataRepository.phoneBooks[index]
    }
    
    // table view delegate didSelectRowAt에서 호출되는 함수
    // 연락처 조회 모드로 PhoneBookView로 이동 : Mode 값 .read, 조회하는 PhoneBook 정보 전달하고 이동
    func pushPhoneBookView(with index: Int) {
        let vc = PhoneBookViewController(coreDataRepository: coreDataRepository)
        vc.mode = .read
        vc.phoneBookID = coreDataRepository.phoneBooks[index].objectID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 우측 상단 추가 bar button 탭했을 때 호출되는 함수
    // 연락처 추가 모드로 PhoneBookView로 이동 : Mode 값 .create
    @objc func addButtonTapped() {
        let vc = PhoneBookViewController(coreDataRepository: coreDataRepository)
        vc.mode = .create
        navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: MainListViewController())
}
