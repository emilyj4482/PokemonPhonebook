//
//  PhoneBookView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

class PhoneBookView: UIView {
    private lazy var randomImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var fetchButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var nameTextView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    private lazy var numberTextView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        configure(PhoneBook.dummy)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubViews([randomImageView, fetchButton, nameTextView, numberTextView])
        
        let offset: CGFloat = 16
        
        randomImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(120)
            $0.trailing.equalToSuperview().offset(-120)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(randomImageView.snp.width)
        }
        
        fetchButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(randomImageView.snp.bottom).offset(offset)
        }
        
        nameTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(fetchButton.snp.bottom).offset(-32)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        numberTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameTextView.snp.bottom).offset(-offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
    }
    
    private func configure(_ phoneBook: PhoneBook) {
        randomImageView.image = UIImage(named: phoneBook.imageURL)
        nameTextView.text = phoneBook.name
        numberTextView.text = phoneBook.phoneNumber
    }
}

extension PhoneBookView {
    @objc func fetchButtonTapped() {
        print("tapped")
    }
}
