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

/// PhoneBookViewController의 컨테이너 뷰
class PhoneBookView: UIView {
    // delegate : PhoneBookController
    weak var delegate: PhoneBookViewDelegate?
    
    // controller로부터 전달 받은 mode 값에 따라 view 새로고침
    var mode: Mode {
        didSet {
            setupView()
        }
    }
    
    /// 랜덤 포켓몬 프사 뷰
    private lazy var randomImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.pokemonball
        
        return imageView
    }()
    
    /// 랜덤 이미지 생성 버튼
    private lazy var fetchButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.setTitleColor(.tertiarySystemFill, for: .disabled)
        button.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    /// 텍스트필드 재사용 함수 : fyi. 텍스트필드는 read 모드에서 hidden
    private func phoneBookTextField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.textAlignment = .left
        
        return textField
    }
    
    /// 이름 입력 받는 텍스트필드
    private lazy var nameTextField = phoneBookTextField("이름")
    
    /// 전화번호 입력 받는 텍스트필드
    private lazy var numberTextField = phoneBookTextField("전화번호")
    
    /// 레이블 재사용 함수 : fyi. 레이블은 create, edit 모드에서 hidden
    private func phoneBookLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        
        return label
    }
    
    /// 이름 레이블
    private lazy var nameLabel = phoneBookLabel()
    
    /// 전화번호 레이블
    private lazy var numberLabel = phoneBookLabel()
    
    /// 연락처 삭제 버튼 : read, create 모드에서 hidden
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
            $0.leading.equalToSuperview().offset(23)
        }
        
        numberLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(numberTextField)
            $0.leading.equalToSuperview().offset(23)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(numberTextField)
            $0.height.equalTo(50)
        }
    }
    
    // 모드에 따라 숨기고 보여줄 뷰를 결정하는 함수
    private func setupView() {
        switch mode {
        case .read:
            hideTextField(true)
        default:
            hideTextField(false)
        }
        hideDeleteButton()
    }
    
    // 텍스트필드를 숨겨야하는 read 모드일 때 true 값을 받아 그에 따라 컴포넌트들의 hidden 값을 설정하는 함수
    private func hideTextField(_ bool: Bool) {
        nameTextField.isHidden = bool
        numberTextField.isHidden = bool
        nameLabel.isHidden = !bool
        numberLabel.isHidden = !bool
        fetchButton.isEnabled = !bool
    }
    
    // 연락처 삭제 버튼이 edit 모드가 아니면 hidden이도록 설정하는 함수
    private func hideDeleteButton() {
        deleteButton.isHidden = mode != .edit
    }
    
    // controller에서 연락처 정보를 받아 ui와 바인딩
    func bind(_ phoneBook: PhoneBook) {
        randomImageView.image = phoneBook.randomImage
        nameLabel.text = phoneBook.name
        numberLabel.text = phoneBook.phoneNumber
    }
    
    // 수정 모드로 바뀔 때 호출되어 텍스트필드에 기존 값이 입력된 상태가 되게 하는 함수
    func bindTextFields(_ phonBook: PhoneBook) {
        nameTextField.text = phonBook.name
        numberTextField.text = phonBook.phoneNumber
    }
}

extension PhoneBookView: ImageBindingDelegate {
    // 랜덤 이미지 생성 버튼이 탭 되었을 때 controller에게 view model의 이미지 fetching 함수를 불러달라고 명령
    @objc func fetchButtonTapped() {
        delegate?.fetchPokemonImage()
    }
    
    // PhoneBookViewModel에서 호출되는 함수로, ImageBindingDelegate를 준수하는 함수
    // view model에서 네트워크 통신을 통해 불러온 이미지를 전달 받아 이미지 뷰와 바인딩한다
    func bindImage(_ image: UIImage) {
        randomImageView.image = image
    }
}

extension PhoneBookView {
    // 연락처 삭제 버튼이 눌렸을 때 controller에게 알려주는 함수
    @objc func deleteButtonTapped() {
        delegate?.deletePhoneBook()
    }
}

extension PhoneBookView {
    // controller에서 "저장" bar button이 눌리면 호출되는 함수
    // 텍스트필드에 입력된 값과 전달 받은 id 값을 조합하여 PhoneBook 데이터를 반환
    func returnPhoneBook(_ id: UUID) -> PhoneBook? {
        guard
            let name = nameTextField.text,
            let number = numberTextField.text,
            let image = randomImageView.image
        else { return nil }
        
        return PhoneBook(id: id, name: name, phoneNumber: number, randomImage: image)
    }
}
