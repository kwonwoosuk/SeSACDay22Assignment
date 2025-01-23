//
//  NicknameViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class NicknameViewController: UIViewController {
    
    let textField = UITextField()
    var contents: ((String) -> Void)?
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let text = textField.text else { return }
        contents?(text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    // 클로저로 전달
    @objc func okButtonTapped() {
        print(#function)
        guard let text = textField.text else { return }
        contents?(text)
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        textField.placeholder = "닉네임을 입력해주세요"
    }
}
