//
//  RootViewController.swift
//  PokemonPhonebook
//
//  Created by EMILY on 14/12/2024.
//

import UIKit

// root view controller에서 작업을 하지 않고, 메인 화면이 되는 List 화면의 ViewController 따로 만들어서 작업 : 나중에 push, background 작업 등에 대해 root vc를 써야하는 경우가 있어 메인 화면과 섞지 않도록 한다.
class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // main vc를 child로 추가
        let vc = UINavigationController(rootViewController: MainListViewController())
        addChild(with: vc)
    }
    
    private func addChild(with child: UIViewController) {
        // add child vc
        addChild(child)
        
        // child view의 view를 root view의 subview로 추가해주고 화면에 꽉 채워준다
        view.addSubview(child.view)
        
        child.view.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view)
        }
        
        // child vc에게 parent에 add 되었음을 알려준다
        child.didMove(toParent: self)
    }
    
    // 호출 X, 참고용 >> root view로부터 child view 제거
    private func removeChild(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
