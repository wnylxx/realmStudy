//
//  BodyPartTableViewCell.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/22/24.
//

import UIKit

class BodyPartTableViewCell: UITableViewCell {
    
    private let bodyPartLabel = UILabel()
    private let exercisesLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bodyPartLabel.font = UIFont.boldSystemFont(ofSize: 16)
        exercisesLabel.font = UIFont.systemFont(ofSize: 14)
        exercisesLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [bodyPartLabel, exercisesLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with data: BodyPartData) {
        bodyPartLabel.text = "\(data.bodyPart) : \(data.totalSets)세트"
        
        var exercisesText = ""
        for exercise in data.exercises {
            exercisesText += "\(exercise.name) : \(exercise.setsCount)세트\n"
        }
        exercisesLabel.text = exercisesText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
