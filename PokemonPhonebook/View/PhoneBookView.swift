//
//  PhoneBookView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

protocol PhoneBookViewDelegate: AnyObject {
    func fetchPokemonImage()
    func deletePhoneBook()
}

class PhoneBookView: UIView {
    weak var delegate: PhoneBookViewDelegate?
    var mode: Mode {
        didSet {
            setupView()
        }
    }
    
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
        button.setTitleColor(.tertiarySystemFill, for: .disabled)
        button.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private func phoneBookTextField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        
        return textField
    }
    
    private lazy var nameTextField = phoneBookTextField("이름")
    
    private lazy var numberTextField = phoneBookTextField("전화번호")
    
    private func phoneBookLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 17)
        
        return label
    }
    
    private lazy var nameLabel = phoneBookLabel()
    
    private lazy var numberLabel = phoneBookLabel()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("연락처 삭제", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitleColor(.opaqueSeparator, for: .highlighted)
        button.backgroundColor = .tertiarySystemFill
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        return button
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
        
        addSubviews([randomImageView, fetchButton, nameTextField, numberTextField, nameLabel, numberLabel, deleteButton])
        
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
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(numberTextField)
            $0.height.equalTo(50)
        }
    }
    
    private func setupView() {
        switch mode {
        case .read:
            hideTextField(true)
        default:
            hideTextField(false)
        }
        hideDeleteButton()
    }
    
    private func hideTextField(_ bool: Bool) {
        nameTextField.isHidden = bool
        numberTextField.isHidden = bool
        nameLabel.isHidden = !bool
        numberLabel.isHidden = !bool
        fetchButton.isEnabled = !bool
    }
    
    private func hideDeleteButton() {
        deleteButton.isHidden = mode != .edit
    }
    
    func bind(_ phoneBook: PhoneBook) {
        randomImageView.image = phoneBook.randomImage
        nameLabel.text = phoneBook.name
        numberLabel.text = phoneBook.phoneNumber
    }
    
    func bindTextFields(_ phonBook: PhoneBook) {
        nameTextField.text = phonBook.name
        numberTextField.text = phonBook.phoneNumber
    }
}

extension PhoneBookView: ImageBindingDelegate {
    @objc func fetchButtonTapped() {
        delegate?.fetchPokemonImage()
    }
    
    func bindImage(_ image: UIImage) {
        randomImageView.image = image
    }
}

extension PhoneBookView {
    @objc func deleteButtonTapped() {
        delegate?.deletePhoneBook()
    }
}

extension PhoneBookView {
    func returnPhoneBook() -> PhoneBook? {
        guard
            let name = nameTextField.text,
            let number = numberTextField.text,
            let image = randomImageView.image
        else {
            return nil
        }
        
        return PhoneBook(name: name, phoneNumber: number, randomImage: image)
    }
}
