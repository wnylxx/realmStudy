//
//  RealmManager.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/21/24.
//

import RealmSwift
import Foundation

class RealmManager {
    static let shared = RealmManager()
    private(set) var localRealm: Realm?
    
    @Published private(set) var inbodyInfos: Results<InBody>? = nil
    
    init() {
        if let realmFileURL = Realm.Configuration.defaultConfiguration.fileURL {
            print("open \(realmFileURL)")
        }
        openRealm()
        createExercisesSampleData()
        generateScheduleSampleData()
        
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    
    func addInbody(weight: Float, bodyFat: Float, muscleMass: Float) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newInbodyInfo = InBody(value: ["weight": weight, "bodyFat": bodyFat, "muscleMass": muscleMass ])
                    localRealm.add(newInbodyInfo)
                    print("Added new Inbody Info")
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    func getInbodyInfo() {
        if let localRealm = localRealm {
            inbodyInfos = localRealm.objects(InBody.self).sorted(byKeyPath: "date")
        }
    }
    
    
        
    
}


extension RealmManager {
    
    func createExercisesSampleData() {
        guard let localRealm = localRealm else {return}
        
        if localRealm.objects(Exercise.self).isEmpty {
            let sampleExercises: [Exercise] = [
            Exercise(name: "Bench Press", bodyParts: [.chest], descriptionText: "A chest exercise", image: nil, totalReps: 100, recentWeight: 80, maxWeight: 100, isCustom: false),
                Exercise(name: "Deadlift", bodyParts: [.back, .hamstrings, .glutes], descriptionText: "A compound exercise for the back and legs", image: nil, totalReps: 50, recentWeight: 120, maxWeight: 150, isCustom: false),
                Exercise(name: "Squat", bodyParts: [.quadriceps, .glutes], descriptionText: "A leg exercise", image: nil, totalReps: 75, recentWeight: 100, maxWeight: 130, isCustom: false),
                Exercise(name: "Shoulder Press", bodyParts: [.shoulders], descriptionText: "An exercise for shoulder strength", image: nil, totalReps: 60, recentWeight: 50, maxWeight: 70, isCustom: false),
                Exercise(name: "Bicep Curl", bodyParts: [.biceps], descriptionText: "An arm exercise", image: nil, totalReps: 80, recentWeight: 30, maxWeight: 40, isCustom: false),
                Exercise(name: "Tricep Extension", bodyParts: [.triceps], descriptionText: "An arm exercise", image: nil, totalReps: 90, recentWeight: 35, maxWeight: 45, isCustom: false),
                Exercise(name: "Leg Press", bodyParts: [.quadriceps], descriptionText: "A leg exercise", image: nil, totalReps: 70, recentWeight: 140, maxWeight: 160, isCustom: false),
                Exercise(name: "Lat Pulldown", bodyParts: [.back], descriptionText: "A back exercise", image: nil, totalReps: 65, recentWeight: 60, maxWeight: 80, isCustom: false),
                Exercise(name: "Lunges", bodyParts: [.quadriceps, .glutes], descriptionText: "A leg exercise", image: nil, totalReps: 50, recentWeight: 40, maxWeight: 50, isCustom: false),
                Exercise(name: "Chest Fly", bodyParts: [.chest], descriptionText: "A chest exercise", image: nil, totalReps: 85, recentWeight: 25, maxWeight: 35, isCustom: false),
                Exercise(name: "Pull-Up", bodyParts: [.back, .biceps], descriptionText: "A back and bicep exercise", image: nil, totalReps: 40, recentWeight: 0, maxWeight: 0, isCustom: false),
                Exercise(name: "Plank", bodyParts: [.abs], descriptionText: "A core exercise", image: nil, totalReps: 100, recentWeight: 0, maxWeight: 0, isCustom: false),
                Exercise(name: "Leg Curl", bodyParts: [.hamstrings], descriptionText: "A leg exercise", image: nil, totalReps: 55, recentWeight: 50, maxWeight: 65, isCustom: false),
                Exercise(name: "Calf Raise", bodyParts: [.calves], descriptionText: "A calf exercise", image: nil, totalReps: 60, recentWeight: 40, maxWeight: 50, isCustom: false),
                Exercise(name: "Side Lateral Raise", bodyParts: [.shoulders], descriptionText: "A shoulder exercise", image: nil, totalReps: 75, recentWeight: 20, maxWeight: 30, isCustom: false),
                Exercise(name: "Tricep Dip", bodyParts: [.triceps], descriptionText: "An arm exercise", image: nil, totalReps: 50, recentWeight: 45, maxWeight: 55, isCustom: false),
                Exercise(name: "Hammer Curl", bodyParts: [.biceps], descriptionText: "An arm exercise", image: nil, totalReps: 90, recentWeight: 25, maxWeight: 35, isCustom: false),
                Exercise(name: "Romanian Deadlift", bodyParts: [.hamstrings, .glutes], descriptionText: "A leg and back exercise", image: nil, totalReps: 70, recentWeight: 110, maxWeight: 130, isCustom: false),
                Exercise(name: "Hip Thrust", bodyParts: [.glutes], descriptionText: "A glute exercise", image: nil, totalReps: 80, recentWeight: 90, maxWeight: 110, isCustom: false),
                Exercise(name: "Cable Crossover", bodyParts: [.chest], descriptionText: "A chest exercise", image: nil, totalReps: 65, recentWeight: 30, maxWeight: 45, isCustom: false)
            ]
            
            try! localRealm.write {
                localRealm.add(sampleExercises)
            }
            print("기본 Exercise 더미데이터 넣기")
        } else {
            print("Exercise 데이터가 존재 합니다.")
        }
    }
}


extension RealmManager {
    
    func generateScheduleSampleData() {
        guard let localRealm = localRealm else {return}
        
        if localRealm.objects(Schedule.self).isEmpty {
            
            let allExercises = localRealm.objects(Exercise.self)
            var schedules: [Schedule] = []
            
            var date = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 1).date!
            let endDate = DateComponents(calendar: Calendar.current, year: 2024, month: 8, day: 31).date!
            
            while date <= endDate {
                var scheduleExercises: [ScheduleExercise] = []
                
                // 각 날짜 별로 3개씩 운동 추가
                for i in 0..<3 {
                    // 운동을 모든 운동중에 랜덤 선택
                    guard let exercise = allExercises.randomElement() else { continue }
                    
                    let sets = [
                        ScheduleExerciseSet(order: 1, weight: 60, reps: 10, isCompleted: true),
                        ScheduleExerciseSet(order: 2, weight: 60, reps: 8, isCompleted: true),
                        ScheduleExerciseSet(order: 3, weight: 60, reps: 6, isCompleted: true)
                    ]
                    
                    let schedulExercise = ScheduleExercise(exercise: exercise, order: i+1, isCompleted: true, sets: sets)
                    scheduleExercises.append(schedulExercise)
                }
                
                let schedule = Schedule(date: date, exercises: scheduleExercises)
                schedules.append(schedule)
                
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                
            }
            
            try! localRealm.write {
                localRealm.add(schedules)
            }
            
            print("Schedule 샘플 데이터를 추가하였습니다.")
        } else {
            print("Schedule 데이터가 존재합니다.")
        }
    }
}

