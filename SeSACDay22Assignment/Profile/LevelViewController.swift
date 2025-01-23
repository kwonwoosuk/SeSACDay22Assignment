//
//  LevelViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class LevelViewController: UIViewController {

    let segmentedControl = UISegmentedControl(items: ["상", "중", "하"])
    
    var level: PassDataDelegate?
    var levelText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        
    }
    
  
        
        
    
    
    @objc func okButtonTapped() {
        print(#function)
        
        
        let selectedIdx = segmentedControl.selectedSegmentIndex
        if let levelText =  segmentedControl.titleForSegment(at: selectedIdx) {
            level?.levelReceived(value: levelText)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    
}
