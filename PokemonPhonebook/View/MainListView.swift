//
//  MainListView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

protocol MainListViewDelegate: AnyObject {
    func pushPhoneBookView(with index: Int)
    func getPhoneBookCount() -> Int
    func getPhoneBook(with index: Int) -> PhoneBook
}

/// MainViewController의 컨테이너 뷰
class MainListView: UIView {
    // delegate : MainViewController
    weak var delegate: MainListViewDelegate?
    
    /// 연락처 목록 뷰
    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.isHidden = true
        
        return tableView
    }()
    
    /// 연락처가 0개일 때 보여주는 뷰
    private lazy var blankView: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .systemBackground
        label.text = "연락처 없음 😕"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .light)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        
        addSubviews([listTableView, blankView])
        
        listTableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        blankView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // MainViewController가 appear 할 때마다 호출되는 함수
    // 연락처가 0개인지 여부를 bool 값으로 받아 숨기고 노출할 뷰를 결정
    func reloadView(_ isBlank: Bool) {
        listTableView.reloadData()
        blankView.isHidden = !isBlank
        listTableView.isHidden = isBlank
    }
}

extension MainListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = delegate?.getPhoneBookCount() else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell,
            let phoneBook = delegate?.getPhoneBook(with: indexPath.row)
        else { return UITableViewCell() }
        
        cell.bind(phoneBook)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pushPhoneBookView(with: indexPath.row)
    }
}
