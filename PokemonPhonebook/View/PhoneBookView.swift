//
//  PhoneBookView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

protocol RandomImageDelegate: AnyObject {
    func fetchPokemonImage(_ id: Int)
}

class PhoneBookView: UIView {
    weak var delegate: RandomImageDelegate?
    
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
    
    private lazy var nameTextField: UITextField = {
        let textView = UITextField()
        
        textView.borderStyle = .roundedRect
        
        return textView
    }()
    
    private lazy var numberTextField: UITextField = {
        let textView = UITextField()
        
        textView.borderStyle = .roundedRect
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        randomImageView.setImageViewRounded()
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        
        addSubViews([randomImageView, fetchButton, nameTextField, numberTextField])
        
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
        
        nameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(fetchButton.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        numberTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameTextField.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
    }
    
    private func configure(_ phoneBook: PhoneBook) {
        randomImageView.image = UIImage(named: phoneBook.imageURL)
        nameTextField.text = phoneBook.name
        numberTextField.text = phoneBook.phoneNumber
    }
}

extension PhoneBookView: PhoneBookViewDelegate {
    @objc func fetchButtonTapped() {
        delegate?.fetchPokemonImage(2)
    }
    
    func bindImage(_ image: UIImage) {
        randomImageView.image = image
    }
}
