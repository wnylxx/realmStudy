//
//  MuscleImageView.swift
//  MVVMTest
//
//  Created by wonyoul heo on 9/2/24.
//

import UIKit

class MuscleImageView: UIView {
    private lazy var frontMuscleImage: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_layout"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleImage: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_layout"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontMuscleChest: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_chest_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleback: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_back_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontMuscleShoulders: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_shoulders_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleShoulders: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_shoulders_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleTriceps: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_triceps_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var frontMuscleBiceps: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_biceps_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontMuscleAbs: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_abs_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontMuscleQuadriceps: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_quadriceps_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleHamstrings: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_hamstrings_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleGlutes: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_glutes_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontMuscleAdductors: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_adductors_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleAdductors: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_adductors_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontMuscleAbductors: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_abductors_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var backMuscleAbductors: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_abductors_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleCalves: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_calves_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontMuscleTrap: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_trap_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backMuscleTrap: UIImageView = {
        let imageView = UIImageView()
        let imageName = "back_body_trap_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontMuscleForearms: UIImageView = {
        let imageView = UIImageView()
        let imageName = "front_body_forearms_01"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        frontMuscleChest.isHidden = true
        backMuscleback.isHidden = true
        frontMuscleShoulders.isHidden = true
        backMuscleShoulders.isHidden = true
        backMuscleTriceps.isHidden = true
        frontMuscleBiceps.isHidden = true
        frontMuscleAbs.isHidden = true
        frontMuscleQuadriceps.isHidden = true
        backMuscleHamstrings.isHidden = true
        backMuscleGlutes.isHidden = true
        frontMuscleAdductors.isHidden = true
        backMuscleAdductors.isHidden = true
        frontMuscleAbductors.isHidden = true
        backMuscleAbductors.isHidden = true
        backMuscleCalves.isHidden = true
        frontMuscleTrap.isHidden = true
        backMuscleTrap.isHidden = true
        frontMuscleForearms.isHidden = true
        
        setupSubview()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() {
        addSubview(frontMuscleChest)
        addSubview(backMuscleback)
        addSubview(frontMuscleShoulders)
        addSubview(backMuscleShoulders)
        addSubview(backMuscleTriceps)
        addSubview(frontMuscleBiceps)
        addSubview(frontMuscleAbs)
        addSubview(frontMuscleQuadriceps)
        addSubview(backMuscleHamstrings)
        addSubview(backMuscleGlutes)
        addSubview(frontMuscleAdductors)
        addSubview(backMuscleAdductors)
        addSubview(frontMuscleAbductors)
        addSubview(backMuscleAbductors)
        addSubview(backMuscleCalves)
        addSubview(frontMuscleTrap)
        addSubview(backMuscleTrap)
        addSubview(frontMuscleForearms)
        addSubview(frontMuscleImage)
        addSubview(backMuscleImage)
        
        
        
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            frontMuscleImage.topAnchor.constraint(equalTo: self.topAnchor),
            frontMuscleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            backMuscleImage.topAnchor.constraint(equalTo: self.topAnchor),
            backMuscleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            frontMuscleChest.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleChest.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
            
            backMuscleback.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleback.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            frontMuscleShoulders.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleShoulders.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
            
            backMuscleShoulders.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleShoulders.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            backMuscleTriceps.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleTriceps.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            frontMuscleBiceps.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleBiceps.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
            
            frontMuscleAbs.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleAbs.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
            
            frontMuscleQuadriceps.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleQuadriceps.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
            
            backMuscleHamstrings.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleHamstrings.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            backMuscleGlutes.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleGlutes.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            frontMuscleAdductors.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleAdductors.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
            
            backMuscleAdductors.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleAdductors.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            frontMuscleAbductors.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleAbductors.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
            
            backMuscleAbductors.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleAbductors.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            backMuscleCalves.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleCalves.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            frontMuscleTrap.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleTrap.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
            
            backMuscleTrap.centerXAnchor.constraint(equalTo: backMuscleImage.centerXAnchor),
            backMuscleTrap.centerYAnchor.constraint(equalTo: backMuscleImage.centerYAnchor),
            
            frontMuscleForearms.centerXAnchor.constraint(equalTo: frontMuscleImage.centerXAnchor),
            frontMuscleForearms.centerYAnchor.constraint(equalTo: frontMuscleImage.centerYAnchor),
        ])
    }
    
    func configureMuscleCell(data: [ReportBodyPartData]) {
        
        for bodyPartData in data {
            let bodyPart = BodyPart(rawValue: bodyPartData.bodyPart)
            
            var imageNamePrefixes: [String] = []
            var imageViews: [UIImageView] = []

            switch bodyPart {
            case .chest:
                imageViews = [frontMuscleChest]
                imageNamePrefixes = ["front_body_chest"]
            case .back:
                imageViews = [backMuscleback]
                imageNamePrefixes = ["back_body_back"]
            case .shoulders:
                imageViews = [frontMuscleShoulders, backMuscleShoulders]
                imageNamePrefixes = ["front_body_shoulders", "back_body_shoulders"]
            case .triceps:
                imageViews = [backMuscleTriceps]
                imageNamePrefixes = ["back_body_triceps"]
            case .biceps:
                imageViews = [frontMuscleBiceps]
                imageNamePrefixes = ["front_body_biceps"]
            case .abs:
                imageViews = [frontMuscleAbs]
                imageNamePrefixes = ["front_body_abs"]
            case .quadriceps:
                imageViews = [frontMuscleQuadriceps]
                imageNamePrefixes = ["front_body_quadriceps"]
            case .hamstrings:
                imageViews = [backMuscleHamstrings]
                imageNamePrefixes = ["back_body_hamstrings"]
            case .glutes:
                imageViews = [backMuscleGlutes]
                imageNamePrefixes = ["back_body_glutes"]
            case .adductors:
                imageViews = [frontMuscleAdductors, backMuscleAdductors]
                imageNamePrefixes = ["front_body_adductors", "back_body_adductors"]
            case .abductors:
                imageViews = [frontMuscleAbductors, backMuscleAbductors]
                imageNamePrefixes = ["front_body_abductors", "back_body_abductors"]
            case .calves:
                imageViews = [backMuscleCalves]
                imageNamePrefixes = ["back_body_calves"]
            case .trap:
                imageViews = [frontMuscleTrap, backMuscleTrap]
                imageNamePrefixes = ["front_body_trap", "back_body_trap"]
            case .forearms:
                imageViews = [frontMuscleForearms]
                imageNamePrefixes = ["front_body_forearms"]
            case .other, .none:
                continue
            }

            // totalSets에 따른 이미지 파일 이름을 결정
            if bodyPartData.totalSets > 0 {
                var imageSuffix = "_01"
                
                switch bodyPartData.totalSets {
                case 1...5:
                    imageSuffix = "_01"
                case 6...15:
                    imageSuffix = "_02"
                case 16...25:
                    imageSuffix = "_03"
                case 26...35:
                    imageSuffix = "_04"
                case 36...:
                    imageSuffix = "_05"
                default:
                    break
                }
                
                // 해당 이미지 뷰들을 보이게 하고 이미지 이름 설정
                for (index, imageView) in imageViews.enumerated() {
                    imageView.isHidden = false
                    imageView.image = UIImage(named: "\(imageNamePrefixes[index])\(imageSuffix)")
                }
            }
        }
    }
}
