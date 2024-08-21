//
//  ViewController.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/20/24.
//

import UIKit

class ViewController: UIViewController {
    private let realmManager = RealmManager.shared
    
    let weightTextField = UITextField()
    let bodyFatTextField = UITextField()
    let muscleMassTextField = UITextField()
    let saveButton = UIButton(type: .system)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        setupUI()
        
        
        
    }
    func setupUI() {
        // UI 요소들 초기화 및 설정
        weightTextField.placeholder = "Enter weight"
        bodyFatTextField.placeholder = "Enter body fat"
        muscleMassTextField.placeholder = "Enter muscle mass"
        
        // 텍스트 필드를 숫자 키패드로 설정
        weightTextField.keyboardType = .numberPad
        bodyFatTextField.keyboardType = .numberPad
        muscleMassTextField.keyboardType = .numberPad
        
        // 저장 버튼 설정
        saveButton.setTitle("Save InBody Info", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        // UI 요소들 스택뷰에 추가
        let stackView = UIStackView(arrangedSubviews: [weightTextField, bodyFatTextField, muscleMassTextField, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    
    @objc func saveButtonTapped() {
        guard let weightText = weightTextField.text, let weight = Float(weightText),
              let bodyFatText = bodyFatTextField.text, let bodyFat = Float(bodyFatText),
              let muscleMassText = muscleMassTextField.text, let muscleMass = Float(muscleMassText) else {
            print("Invalid input")
            return
        }
        
        realmManager.addInbody(weight: weight, bodyFat: bodyFat, muscleMass: muscleMass)
    }
    
}

