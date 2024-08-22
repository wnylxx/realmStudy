//
//  ViewController02.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/21/24.
//

import UIKit

class ViewController02: UIViewController, UITableViewDataSource {
    let realm = RealmManager.shared.localRealm
    
    var bodyPartSetsCount: [(key: String, value: Int)] = []
    private var tableView = UITableView()
    private var label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "8월 부위별 총 세트 수"
        
        tableView.dataSource = self
        
        view.addSubview(label)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        label.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
        
       
        
        let schedules = fetchAugustSchedules()
        bodyPartSetsCount = calculateSetsByBodyPart(schedules: schedules)
        tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bodyPartSetsCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let bodyPart = bodyPartSetsCount[indexPath.row].key
        let setsCount = bodyPartSetsCount[indexPath.row].value
        cell.textLabel?.text = "\(bodyPart) : \(setsCount)세트"
        return cell
    }
    
    // 8월 데이터 필터링
    func fetchAugustSchedules() -> [Schedule] {
        guard let realm = realm else { return [] }
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 8, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: 2024, month: 8, day: 31))!
        
        let result = Array(realm.objects(Schedule.self).filter("date >= %@ AND date <= %@", startDate, endDate) )
        print(" August fetch success ")
        
        return result
    }
    
    func calculateSetsByBodyPart(schedules: [Schedule]) -> [(key: String, value: Int)] {
        var bodyPartSetsCount: [String: Int] = [:]
        
        for schedule in schedules {
            for scheduleExercise in schedule.exercises {
                guard let exercise = scheduleExercise.exercise else { continue }
                
                let completedSets = scheduleExercise.sets.filter { $0.isCompleted }
                
                for bodyPart in exercise.bodyParts {
                    let bodyPartName = bodyPart.rawValue
                    bodyPartSetsCount[bodyPartName, default: 0] += completedSets.count
                }
            }
        }
        
        // 정열된 배열은 딕셔너리가 아닌 튜플로 반환 된다. [(key: String, value: Int)]
        let sortedCount = bodyPartSetsCount.sorted {$0.value > $1.value }
        
        // cell에 뿌릴 때 key, value로 접근해야함.
        // 여기서 Dictionary로 다시 반환해 주면 Dictionary는 순서를 보장하지 않기 때문에 정렬 순서가 꼬이게 된다.
        
        return sortedCount
    }
    
}
