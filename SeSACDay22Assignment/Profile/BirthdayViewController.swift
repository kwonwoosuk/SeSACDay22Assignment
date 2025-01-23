//
//  BirthdayViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class BirthdayViewController: UIViewController {

    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    // notificationCenter 활용 전달
    @objc func okButtonTapped() {
        print(#function)
        let date = datePicker.date
        
        NotificationCenter.default.post(name: NSNotification.Name("birthDay"),
                                        object: nil, // object는 아직 이해 하지 않아도 된다고 하셨다 잠깐 신경끄자
                                        userInfo: ["birthday" : date]) // 
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 넣어줍니다.
      
    }
    
    
    
    
    
    func configureView() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
    
    
    
    
   
    
    
}
