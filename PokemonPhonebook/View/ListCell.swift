//
//  ListCell.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

class ListCell: UITableViewCell {
    static let identifier: String = "ListCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
