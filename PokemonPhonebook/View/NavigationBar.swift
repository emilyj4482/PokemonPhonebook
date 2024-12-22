//
//  NavigationBar.swift
//  PokemonPhonebook
//
//  Created by EMILY on 21/12/2024.
//

import UIKit

class NavigationBar: UIView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var leftBarButtonAction: (() -> Void)?
    var rightBarButtonAction: (() -> Void)?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var leftBarButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .plain()
        button.configuration?.title = "Back"
        button.configuration?.image = UIImage(systemName: "chevron.backward")
        button.configuration?.imagePadding = 4
        button.configuration?.preferredSymbolConfigurationForImage = .init(weight: .medium)
        
        return button
    }()
    
    private lazy var rightBarButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews([titleLabel, leftBarButton, rightBarButton])
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        leftBarButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(4)
        }
        
        rightBarButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-4)
        }
    }
    
    private func setupButtons() {
        leftBarButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)
    }
    
    func setLeftBarButtonTitle(_ title: String) {
        leftBarButton.configuration?.title = title
    }
    
    func setRightBarButtonTitle(_ title: String) {
        rightBarButton.configuration?.title = title
    }
    
    func hideLeftBarButton() {
        leftBarButton.isHidden = true
    }
    
    func hideRightBarButton() {
        rightBarButton.isHidden = true
    }
    
    @objc func leftBarButtonTapped() {
        leftBarButtonAction?()
    }
    
    @objc func rightBarButtonTapped() {
        rightBarButtonAction?()
    }
}
