//
//  ProfileViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit


protocol PassDataDelegate {
    func levelReceived(value: String)
}

class ProfileViewController: UIViewController {

    let savebutton = UIButton()
    
    let nicknameButton = UIButton()
    let birthdayButton = UIButton()
    let levelButton = UIButton()
    
    let nicknameLabel = UILabel()
    let birthdayLabel = UILabel()
    let levelLabel = UILabel()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadData()
    
        nicknameButton.addTarget(self, action: #selector(nicknameButtonTapped), for: .touchUpInside)
        birthdayButton.addTarget(self, action: #selector(birthdayButtonTapped), for: .touchUpInside)
        levelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
        savebutton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        
        view.backgroundColor = .white
        view.addSubview(savebutton)
        savebutton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
        savebutton.layer.cornerRadius = 25
        savebutton.backgroundColor = .white
        savebutton.setTitleColor(.darkGray, for: .normal)
        savebutton.setTitle("저장하기", for: .normal)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(birthDayReceivedNotification),
                                               name: NSNotification.Name("birthDay"),
                                               object: nil)
               
    }
    
    func loadData() {
        nicknameLabel.text = UserDefaults.standard.string(forKey: "nickname")
        birthdayLabel.text = UserDefaults.standard.string(forKey: "birth")
        levelLabel.text = UserDefaults.standard.string(forKey: "level")
    }
    
    
    @objc
    func saveButtonTapped() {
        UserDefaults.standard.set(nicknameLabel.text, forKey: "nickname")
        UserDefaults.standard.set(birthdayLabel.text, forKey: "birth")
        UserDefaults.standard.set(levelLabel.text, forKey: "level")
    }
    
    
    @objc func okButtonTapped() {
        print(#function)
        var start = UserDefaults.standard.integer(forKey: "start")
        start = 0
        UserDefaults.standard.set(start, forKey: "start")
        print(start)
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "birth")
        UserDefaults.standard.removeObject(forKey: "level")
        
        
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        window.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        window.makeKeyAndVisible()
        
    }
    
    func configureView() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        
        view.addSubview(nicknameButton)
        view.addSubview(birthdayButton)
        view.addSubview(levelButton)
        
        view.addSubview(nicknameLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(levelLabel)
        
        nicknameButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(nicknameButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }

        levelButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(birthdayButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }

        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(levelButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }

        
        
        nicknameButton.setTitleColor(.black, for: .normal)
        birthdayButton.setTitleColor(.black, for: .normal)
        levelButton.setTitleColor(.black, for: .normal)
        
        nicknameButton.setTitle("닉네임", for: .normal)
        birthdayButton.setTitle("생일", for: .normal)
        levelButton.setTitle("레벨", for: .normal)

        nicknameLabel.text = "NO NAME"
        nicknameLabel.textColor = .lightGray
        nicknameLabel.textAlignment = .right
        
        birthdayLabel.text = "NO DATE"
        birthdayLabel.textColor = .lightGray
        birthdayLabel.textAlignment = .right
        
        levelLabel.text = "NO LEVEL"
        levelLabel.textColor = .lightGray
        levelLabel.textAlignment = .right
    }
    
 
    @objc// Closure
    func nicknameButtonTapped() {
        let vc = NicknameViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.textField.text = nicknameLabel.text
        vc.contents = { value in
            self.nicknameLabel.text = value
        }
    }
    
    
    
    @objc // NotificationCenter
    func birthdayButtonTapped() {
        let vc = BirthdayViewController()
        if let birthday = birthdayLabel.text {
            vc.datePicker.date = dateFormat(string: birthday) ?? Date()
        }
        
         
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func birthDayReceivedNotification(value: NSNotification) {
        if let birthDay = value.userInfo!["birthday"] as? Date {
            birthdayLabel.text = dateFormat(date: birthDay)
        } else {
            print("값전달 오류")
        }
    }
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년MM월dd일"
        return formatter.string(from: date)
    }
    
    private func dateFormat(string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년MM월dd일"
        return formatter.date(from: string)
    }
    
    
    
    
    @objc // delegate
    func levelButtonTapped() {
        let vc = LevelViewController()
        vc.level = self
        
        
        switch levelLabel.text {
        case "상":
            vc.segmentedControl.selectedSegmentIndex = 0
        case "중":
            vc.segmentedControl.selectedSegmentIndex = 1
        case "하":
            vc.segmentedControl.selectedSegmentIndex = 2
        default:
            vc.segmentedControl.selectedSegmentIndex = 0
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProfileViewController: PassDataDelegate {
    func levelReceived(value: String) {
        print(#function)
        levelLabel.text = value
        
    }
    
    
}
