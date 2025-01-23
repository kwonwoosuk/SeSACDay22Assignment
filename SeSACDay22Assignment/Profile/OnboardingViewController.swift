//
//  OnboardingViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    let button = UIButton()
    var start = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(start)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        
        view.backgroundColor = .darkGray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("시작하기", for: .normal)
        
        
    }
    @objc
    func startButtonTapped() {
        start = 1
        UserDefaults.standard.set(start, forKey: "start")
        print(start)
        
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
 
}
