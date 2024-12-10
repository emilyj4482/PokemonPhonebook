//
//  PhoneBookView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

protocol PhoneBookViewDelegate: AnyObject {
    func fetchPokemonImage(_ id: Int)
}

class PhoneBookView: UIView {
    weak var delegate: PhoneBookViewDelegate?
    var mode: Mode
    
    private lazy var randomImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.pokemonball
        
        return imageView
    }()
    
    private lazy var fetchButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.setTitleColor(.placeholderText, for: .disabled)
        button.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "이름"
        
        return textField
    }()
    
    private lazy var numberTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "전화번호"
        
        return textField
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    init(frame: CGRect = .zero, mode: Mode) {
        self.mode = mode
        super.init(frame: frame)
        layout()
        setupView()
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
        
        addSubViews([randomImageView, fetchButton, nameTextField, numberTextField, nameLabel, numberLabel])
        
        let offset: CGFloat = 16
        
        randomImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(120)
            $0.trailing.equalToSuperview().offset(-120)
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
        
        nameLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(nameTextField)
            $0.leading.equalTo(nameTextField.textInputView)
        }
        
        numberLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(numberTextField)
            $0.leading.equalTo(numberTextField.textInputView)
        }
    }
    
    private func setupView() {
        switch mode {
        case .read:
            hideTextField(true)
        case .create:
            hideTextField(false)
        case .edit:
            hideTextField(false)
        }
    }
    
    private func hideTextField(_ bool: Bool) {
        nameTextField.isHidden = bool
        numberTextField.isHidden = bool
        nameLabel.isHidden = !bool
        numberLabel.isHidden = !bool
        fetchButton.isEnabled = !bool
    }
    
    func configure(_ phoneBook: PhoneBook) {
        randomImageView.image = UIImage(named: phoneBook.imageURL)
        nameLabel.text = phoneBook.name
        numberLabel.text = phoneBook.phoneNumber
    }
}

extension PhoneBookView: ImageBindingDelegate {
    @objc func fetchButtonTapped() {
        delegate?.fetchPokemonImage(2)
    }
    
    func bindImage(_ image: UIImage) {
        randomImageView.image = image
    }
}
