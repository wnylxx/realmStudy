//
//  ExerciseRecordViewController.swift
//  MVVMTest
//
//  Created by wonyoul heo on 9/2/24.
//

import UIKit

class ExerciseRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let reportsVM: ReportsViewModel
    
    init(reportsVM: ReportsViewModel) {
        self.reportsVM = reportsVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var exerciseRecordTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor(named: "Color525252")


        // 테이믈 가장 맨위 여백 지우기 (insetGroup)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        tableView.cellLayoutMarginsFollowReadableWidth = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableViewRegister()
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reportsVM.bodyPartDataList.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if reportsVM.bodyPartDataList.isEmpty {
            return 1
        }
        
        switch section {
        case 0:
            return 1
        case 1:
            return reportsVM.bodyPartDataList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "muscle", for: indexPath) as! MuscleImageTableViewCell
            cell.backgroundColor = UIColor.blue
            cell.selectionStyle = .none
            cell.configureCell(data: reportsVM.bodyPartDataList)
            
            return cell
        case 1:
            let data = reportsVM.bodyPartDataList[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalNumber", for: indexPath) as! TotalNumberPerBodyPartTableViewCell
            cell.backgroundColor = UIColor.blue
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            
            cell.configureCell(with: data, at: indexPath)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 372
        case 1:
            let data = reportsVM.bodyPartDataList[indexPath.row]
            let defaultCellHeight: CGFloat = 40
            let exerciseViewHeight: CGFloat = 25
            
            if data.isStackViewVisible {
                let exercisesCount = data.exercises.count
                return defaultCellHeight + (exerciseViewHeight * CGFloat(exercisesCount))
            } else {
                return defaultCellHeight
            }
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {return}
        
        reportsVM.bodyPartDataList[indexPath.row].isStackViewVisible.toggle()
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}


extension ExerciseRecordViewController {
    
    
    func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(exerciseRecordTableView)
        
        NSLayoutConstraint.activate([
            exerciseRecordTableView.topAnchor.constraint(equalTo: view.topAnchor),
            exerciseRecordTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            exerciseRecordTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exerciseRecordTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    func setupTableViewRegister() {
        exerciseRecordTableView.dataSource = self
        exerciseRecordTableView.delegate = self
        
        exerciseRecordTableView.register(MuscleImageTableViewCell.self, forCellReuseIdentifier: "muscle")
        exerciseRecordTableView.register(TotalNumberPerBodyPartTableViewCell.self, forCellReuseIdentifier: "totalNumber")
//        exerciseRecordTableView.register(SectionTitleTableViewCell.self, forCellReuseIdentifier: "sectionTitle")
//        exerciseRecordTableView.register(MostPerformedTableViewCell.self, forCellReuseIdentifier: "mostPerform")
//        exerciseRecordTableView.register(MostChangedTableViewCell.self, forCellReuseIdentifier: "mostChanged")
//        exerciseRecordTableView.register(NoDataTableViewCell.self, forCellReuseIdentifier: NoDataTableViewCell.identifier)
    }
}
