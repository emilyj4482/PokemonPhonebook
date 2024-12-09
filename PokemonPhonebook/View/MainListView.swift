//
//  MainListView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

class MainListView: UIView {
    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
