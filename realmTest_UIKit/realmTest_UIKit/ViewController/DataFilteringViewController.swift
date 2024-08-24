//
//  ViewController02.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/21/24.
//

import UIKit

class DataFilteringViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let realm = RealmManager.shared.localRealm
    

    
    
//    var bodyPartSetsCount: [(key: String, value: Int)] = []
    private var bodyPartDataList: [BodyPartData] = []
    
    private var tableView = UITableView()
    private var label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "8월 부위별 총 세트 수"
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 44
        
        
        view.addSubview(label)
        view.addSubview(tableView)
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(BodyPartTableViewCell.self, forCellReuseIdentifier: "BodyPartCell")
        
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
        bodyPartDataList = calculateSetsByBodyPartAndExercise(schedules: schedules)
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // data의 isStackViewVisible 값을 토글
            bodyPartDataList[indexPath.row].isStackViewVisible.toggle()
            
            // 선택된 셀만 리로드
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bodyPartDataList.count
    }
    
    //    // 수동 높이 설정
        private let defaultCellHeight: CGFloat = 40
        private let exerciseViewHeight: CGFloat = 25
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = bodyPartDataList[indexPath.row]
        
        if data.isStackViewVisible {
                // `exercisesStackView`가 보이는 상태일 때 높이 계산
                let exercisesCount = data.exercises.count
                return defaultCellHeight + (exerciseViewHeight * CGFloat(exercisesCount))
            } else {
                // `exercisesStackView`가 숨겨진 상태일 때 기본 높이 반환
                return defaultCellHeight
            }
        
    }
    
    func toggleStackViewVisibility(for indexPath: IndexPath) {
        var data = bodyPartDataList[indexPath.row]
        data.isStackViewVisible.toggle()
        bodyPartDataList[indexPath.row] = data
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BodyPartCell", for: indexPath) as! BodyPartTableViewCell
        let data = bodyPartDataList[indexPath.row]
        
        cell.configure(with: data, at: indexPath) { [weak self] indexPath in
            self?.toggleStackViewVisibility(for: indexPath)
        }
        
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
    
    
    func calculateSetsByBodyPartAndExercise(schedules: [Schedule]) -> [BodyPartData] {
        var bodyPartDataList: [BodyPartData] = []

        for schedule in schedules {
            for scheduleExercise in schedule.exercises {
                let completedSets = scheduleExercise.sets.filter { $0.isCompleted }
                let setsCount = completedSets.count

                for bodyPart in scheduleExercise.exercise!.bodyParts {
                    let bodyPartName = bodyPart.rawValue
                    
                    if let index = bodyPartDataList.firstIndex(where: { $0.bodyPart == bodyPartName }) {
                        bodyPartDataList[index].totalSets += setsCount
                        let exerciseName = scheduleExercise.exercise!.name
                        if let exerciseIndex = bodyPartDataList[index].exercises.firstIndex(where: { $0.name == exerciseName }) {
                            bodyPartDataList[index].exercises[exerciseIndex].setsCount += setsCount
                        } else {
                            bodyPartDataList[index].exercises.append(ExerciseSets(name: exerciseName, setsCount: setsCount))
                        }
                    } else {
                        let newData = BodyPartData(bodyPart: bodyPartName, totalSets: setsCount, exercises: [ExerciseSets(name: scheduleExercise.exercise!.name, setsCount: setsCount)])
                        bodyPartDataList.append(newData)
                    }
                }
            }
        }

        bodyPartDataList.sort { $0.totalSets > $1.totalSets }
        for i in 0..<bodyPartDataList.count {
            bodyPartDataList[i].exercises.sort {$0.setsCount > $1.setsCount}
        }
        
        
        return bodyPartDataList
    }
}



