//
//  +UIImageView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

/// 이미지 뷰를 동그라미로 만들고 회색 테두리를 그려주는 함수
/// MainListView와 PhoneBookView에서 재사용된다
extension UIImageView {
    func setImageViewRounded() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
}
