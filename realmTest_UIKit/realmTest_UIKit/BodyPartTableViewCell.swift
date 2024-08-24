//
//  BodyPartTableViewCell.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/22/24.
//

import UIKit

class BodyPartTableViewCell: UITableViewCell {
    
    private let bodyPartLabel = UILabel()
    private let exercisesStackView = UIStackView()
    private let toggleButton = UIButton(type: .system)
    
    private var indexPath: IndexPath?
    private var toggleVisibilityAction: ((IndexPath) -> Void)?
    
    private var isStackViewVisible = true {
        didSet {
            // 스택 뷰의 가시성을 변경합니다
            if isStackViewVisible {
                // 스택 뷰를 추가합니다
                if exercisesStackView.superview == nil {
                    contentView.addSubview(exercisesStackView)
                    NSLayoutConstraint.activate([
                        exercisesStackView.topAnchor.constraint(equalTo: bodyPartLabel.bottomAnchor, constant: 8),
                        exercisesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                        exercisesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                        exercisesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
                    ])
                }
            } else {
                // 스택 뷰를 제거합니다
                exercisesStackView.removeFromSuperview()
            }
            
            toggleButton.setTitle(isStackViewVisible ? "Hide" : "Show", for: .normal)
            
            //                setNeedsLayout()
            //                layoutIfNeeded()
            
            // 테이블 뷰 업데이트
            if let tableView = superview as? UITableView {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bodyPartLabel.font = UIFont.boldSystemFont(ofSize: 16)
        bodyPartLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        bodyPartLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        
        exercisesStackView.axis = .vertical
        //        exercisesStackView.spacing = 12
        exercisesStackView.alignment = .leading
        exercisesStackView.distribution = .equalSpacing
        exercisesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        toggleButton.setTitle("Hide", for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleStackViewVisibility), for: .touchUpInside)
        
        contentView.addSubview(bodyPartLabel)
        contentView.addSubview(toggleButton)
        
        bodyPartLabel.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            bodyPartLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bodyPartLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bodyPartLabel.trailingAnchor.constraint(equalTo: toggleButton.leadingAnchor, constant: -8),
            
            toggleButton.centerYAnchor.constraint(equalTo: bodyPartLabel.centerYAnchor),
            toggleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func toggleStackViewVisibility() {
        
        guard let indexPath = indexPath else { return }
        toggleVisibilityAction?(indexPath)
        
    }
    
    func toggleStackViewVisibilityDelegate() {
        isStackViewVisible.toggle()
        
    }
    
    
    func configure(with data: BodyPartData, at indexPath: IndexPath, toggleVisibilityAction: @escaping (IndexPath) -> Void) {
        bodyPartLabel.text = "\(data.bodyPart) : \(data.totalSets)세트"
        
        exercisesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for exercise in data.exercises {
            let exerciseView = HorizontalExerciseView()
            exerciseView.configure(name: exercise.name, setsCount: exercise.setsCount)
            exercisesStackView.addArrangedSubview(exerciseView)
        }
        
        self.indexPath = indexPath
        self.toggleVisibilityAction = toggleVisibilityAction
        isStackViewVisible = data.isStackViewVisible
    }
}

class HorizontalExerciseView: UIView {
    private let nameLabel = UILabel()
    private let setsLabel = UILabel()
    private let stackView = UIStackView()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        stackView.axis = .horizontal
//        stackView.alignment = .fill
        stackView.spacing = 10

        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        setsLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(setsLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    func configure(name: String, setsCount: Int) {
        nameLabel.text = name
        setsLabel.text = "\(setsCount)세트"
    }
}


