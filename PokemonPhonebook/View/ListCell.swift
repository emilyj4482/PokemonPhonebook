//
//  ListCell.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit
import SnapKit

/// MainListView > listTableView의 셀
class ListCell: UITableViewCell {
    static let identifier: String = "ListCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.setImageViewRounded()
    }
    
    private func layout() {
        selectionStyle = .none
        backgroundColor = .systemBackground
        
        addSubviews([profileImageView, nameLabel, numberLabel])
        
        let offset: CGFloat = 16
        
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(profileImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(offset)
        }
        
        numberLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-offset)
        }
    }
    
    func bind(_ phoneBook: PhoneBook) {
        profileImageView.image = phoneBook.randomImage
        nameLabel.text = phoneBook.name
        numberLabel.text = phoneBook.phoneNumber
    }
}
