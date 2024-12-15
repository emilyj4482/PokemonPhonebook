//
//  PhoneBookViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 08/12/2024.
//

import UIKit

/// 연락처 추가/조회/수정 화면 controller
class PhoneBookViewController: UIViewController {
    private let vm: PhoneBookViewModel = .init()
    
    private let imageRepository: ImageRepository = .init()
    private lazy var containerView: PhoneBookView = .init(mode: mode)
    
    var mode: Mode = .read
    var phoneBook: PhoneBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        layout()
        setDelegate()
        configureViewByMode()
    }
    
    private func setNavigationBar() {
        // mode에 따라 bar button 타이틀 다르게 설정 (수정 or 저장)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: mode.buttonTitle, style: .plain, target: self, action: #selector(barButtonTapped))
    }
    
    private func layout() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setDelegate() {
        containerView.delegate = self
    }
    
    // 모드에 따라 view를 다르게 설정하는 함수
    private func configureViewByMode() {
        switch mode {
        case .read:
            /// 조회 모드 일 때 네비게이션 타이틀을 연락처 이름으로 설정하고 컨테이너 view에도 연락처 정보를 바인딩 시켜준다
            guard let phoneBook = phoneBook else { return }
            navigationItem.title = phoneBook.name
            containerView.bind(phoneBook)
        case .create:
            /// 추가 모드 일 때 네비게이션 타이틀을 "연락처 추가"로 지정해주고 자동으로 랜덤 포켓몬 프사를 띄운다
            navigationItem.title = "연락처 추가"
            fetchPokemonImage()
        case .edit:
            /// 수정 모드로의 전환은 조회에서 넘어가는 것만 가능하기 때문에 네비게이션 타이틀을 바꿔줄 필요가 없음
            return
        }
    }
}

extension PhoneBookViewController: PhoneBookViewDelegate {
    func fetchPokemonImage() {
        // vm.fetchPokemon()
        imageRepository.fetchPokemon { [weak self] image in
            guard let self = self, let image = image else { return }
            self.containerView.bindImage(image)
        }
    }
    
    // 우측 상단 bar button이 모드에 따라 다르게 동작하도록 분기하는 함수
    @objc func barButtonTapped() {
        switch mode {
        case .read:
            // 조회 모드에서 수정 모드로 전환
            mode = .edit
            containerView.mode = mode
            navigationItem.rightBarButtonItem?.title = mode.buttonTitle
            // 조회 중인 연락처 정보가 입력된 상태의 textfield가 뜨도록 컨테이너 뷰 바인딩
            guard let phoneBook = phoneBook else { return }
            containerView.bindTextViews(phoneBook)
        case .create:
            // 추가 버튼이 눌리면 입력된 내용으로 연락처 정보를 생성하고 메인 목록 화면으로 돌아간다
            createPhoneBook()
            navigationController?.popViewController(animated: true)
        case .edit:
            // 수정 모드에서 저장 버튼이 눌리면 입력된 내용을 바탕으로 연락처 정보를 업데이트하고, 업데이트 내용이 반영된 상태로 조회모드로 전환
            updatePhoneBook()
            mode = .read
            containerView.mode = mode
            configureViewByMode()
            navigationItem.rightBarButtonItem?.title = mode.buttonTitle
        }
    }
    
    /// 추가 모드에서 "추가" 버튼이 눌렸을 때 호출되는 함수
    /// 컨테이너 뷰로부터 입력된 내용을 바탕으로 PhoneBook 정보를 받아 view model에 전달
    private func createPhoneBook() {
        guard let phoneBook = containerView.returnPhoneBook(.init()) else { return }
        vm.addPhoneBook(phoneBook)
    }
    
    /// 수정 모드에서 "저장" 버튼이 눌렸을 때 호출되는 함수
    /// 컨테이너 뷰 안에 있는 텍스트필드에 입력된 이름과 전화번호를 수정 중인 연락처의 id 값과 조합하여 view model에 전달
    private func updatePhoneBook() {
        guard
            let id = phoneBook?.id,
            let phoneBook = containerView.returnPhoneBook(id)
        else { return }
        // 수정한 내용이 반영되어 조회 모드로 넘어가도록 controller의 phoneBook에 새로운 phoneBook 값 할당
        self.phoneBook = phoneBook
        vm.updatePhoneBook(phoneBook)
    }
    
    /// 수정 모드에서 하단 "연락처 삭제" 버튼이 눌렸을 때 호출되는 함수
    /// 연락처의 id 값을 view model에 전달하고 연락처 목록 화면으로 돌아간다
    func deletePhoneBook() {
        guard let id = phoneBook?.id else { return }
        vm.deletePhoneBook(of: id)
        navigationController?.popViewController(animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: PhoneBookViewController())
}
