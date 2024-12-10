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

class MainListView: UIView {
    
    weak var delegate: MainListViewDelegate?
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        
        return tableView
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
        
        addSubview(listTableView)
        
        listTableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
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
