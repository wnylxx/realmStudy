//
//  RealmManager.swift
//  MVVMTest
//
//  Created by wonyoul heo on 9/2/24.
//

import Foundation
import RealmSwift


class RealmManager {
    static let shared = RealmManager()
    private(set) var realm: Realm?
    
    
    private init() {
        if let realmFileURL = Realm.Configuration.defaultConfiguration.fileURL {
            print("open \(realmFileURL)")
        }
        
        openRealm()
        
        initializeRealmExercise()
        generateScheduleSampleData()
        addInBodySampleData()
        
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            realm = try Realm()
            
        } catch {
            print("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    
    func addInbody(weight: Float, bodyFat:Float, muscleMass: Float) {
        if let realm = realm {
            do {
                try realm.write {
                    // 현재 시간을 한국 시간으로 변환
                    let koreanDate = Date().toKoreanTime()
                    // 날짜 범위 설정(같은 날짜의 데이터를 찾기 위함)
                    let startOfDay = Calendar.current.startOfDay(for: koreanDate)
                    let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
                    // 현재 날짜만 선택하여 기존 데이터를 조회
                    let existingInbody = realm.objects(InBody.self).filter("date >= %@ AND date < %@", startOfDay, endOfDay)
                    // 같은 날짜에 이미 기록이 존재하면 데이터를 업데이트
                    if let existingInBodyRecord = existingInbody.first {
                        existingInBodyRecord.weight = weight
                        existingInBodyRecord.bodyFat = bodyFat
                        existingInBodyRecord.muscleMass = muscleMass
                        existingInBodyRecord.date = koreanDate
                    } else {
                        // 같은 날짜에 기록이 없으면 새로운 기록 추가
                        let newInbodyInfo = InBody(value: ["weight": weight, "bodyFat": bodyFat, "muscleMass": muscleMass, "date": koreanDate])
                        realm.add(newInbodyInfo)
                        print("Added new Inbody Info")
                    }
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
}

extension Date {
    func toKoreanTime() -> Date {
        let timeZone = TimeZone(identifier: "Asia/Seoul")!
        let seconds = TimeInterval(timeZone.secondsFromGMT(for: self))
        return addingTimeInterval(seconds)
    }
}

extension RealmManager {
    
    func initializeRealmExercise() {
        guard let realm = realm else {return}
        
        if realm.objects(Exercise.self).isEmpty {
            let sampleExercises = [
                Exercise(
                    name: "스쿼트", bodyParts: [.quadriceps, .glutes],
                    descriptionText: "다리 운동", images: [],
                    totalReps: 75, recentWeight: 80, maxWeight: 120,
                    isCustom: true
                ),
                Exercise(name: "Shoulder Press", bodyParts: [.shoulders], descriptionText: "Shoulder exercise TestTe stTestTestTestT estTest TestTestTestTestT estTestT TestTestTestTestTestTe stTestTe stTestTestTes tTestTestTestTest ", images: [], totalReps: 60, recentWeight: 40, maxWeight: 60, isCustom: false),
                Exercise(name: "Bicep Curl", bodyParts: [.biceps], descriptionText: "Arm exercise", images: [], totalReps: 90, recentWeight: 20, maxWeight: 30, isCustom: false),
                Exercise(name: "Tricep Dip", bodyParts: [.triceps], descriptionText: "Arm exercise", images: [
                    ExerciseImage(
                        image: nil, url: "https://upload.wikimedia.org/wikipedia/commons/5/5d/Squats-1.png",
                        urlAccessCount: 0),
                    ExerciseImage(
                        image: nil, url: "https://upload.wikimedia.org/wikipedia/commons/6/6f/Squats-2.png",
                        urlAccessCount: 0)
                ], totalReps: 80, recentWeight: 25, maxWeight: 40, isCustom: false),
                Exercise(name: "Lateral Raise", bodyParts: [.shoulders], descriptionText: "Shoulder isolation exercise", images: [], totalReps: 70, recentWeight: 10, maxWeight: 15, isCustom: false),
                Exercise(name: "레그 프레스", bodyParts: [.quadriceps, .glutes], descriptionText: "다리 운동2", images: [], totalReps: 50, recentWeight: 180, maxWeight: 200, isCustom: true),
                Exercise(name: "Plank", bodyParts: [.abs], descriptionText: "Core exercise", images: [
                    ExerciseImage(
                        image: nil, url: "https://upload.wikimedia.org/wikipedia/commons/6/6f/Squats-2.png",
                        urlAccessCount: 0)
                ], totalReps: 5, recentWeight: 0, maxWeight: 0, isCustom: false),
                Exercise(name: "Leg Curl", bodyParts: [.hamstrings], descriptionText: "Hamstring exercise", images: [], totalReps: 60, recentWeight: 50, maxWeight: 60, isCustom: false),
                Exercise(name: "Calf Raise", bodyParts: [.calves, .biceps, .forearms, .abductors, .quadriceps, .triceps], descriptionText: "Calf exercise", images: [], totalReps: 100, recentWeight: 20, maxWeight: 30, isCustom: false),
                Exercise(name: "Pull-up", bodyParts: [.back, .biceps], descriptionText: "Back and biceps exercise", images: [], totalReps: 40, recentWeight: 0, maxWeight: 0, isCustom: false),
                Exercise(name: "Chest Fly", bodyParts: [.chest], descriptionText: "Chest isolation exercise", images: [], totalReps: 70, recentWeight: 25, maxWeight: 40, isCustom: false),
                Exercise(name: "Russian Twist", bodyParts: [.abs], descriptionText: "Core rotational exercise", images: [], totalReps: 50, recentWeight: 0, maxWeight: 0, isCustom: false),
                Exercise(name: "Glute Bridge", bodyParts: [.glutes], descriptionText: "Glute exercise", images: [], totalReps: 30, recentWeight: 40, maxWeight: 60, isCustom: false),
                Exercise(name: "Lunges", bodyParts: [.quadriceps, .glutes], descriptionText: "Leg exercise", images: [], totalReps: 60, recentWeight: 20, maxWeight: 30, isCustom: false),
                Exercise(name: "Hammer Curl", bodyParts: [.biceps], descriptionText: "Bicep exercise", images: [], totalReps: 80, recentWeight: 15, maxWeight: 25, isCustom: false),
                Exercise(name: "Tricep Kickback", bodyParts: [.triceps], descriptionText: "Tricep isolation exercise", images: [], totalReps: 75, recentWeight: 10, maxWeight: 15, isCustom: false),
                Exercise(name: "Side Plank", bodyParts: [.abs], descriptionText: "Core stabilization exercise", images: [], totalReps: 5, recentWeight: 0, maxWeight: 0, isCustom: false),
                Exercise(name: "Hip Thrust", bodyParts: [.glutes], descriptionText: "Glute exercise", images: [], totalReps: 50, recentWeight: 60, maxWeight: 80, isCustom: false)
            ]
            
            try! realm.write {
                realm.add(sampleExercises)
            }
            
            print("기본 Exercise 더미데이터 넣기")
        } else {
            print("기본 Exercise 데이터가 이미 존재합니다.")
        }
    }
    
    func generateScheduleSampleData() {
        guard let realm = realm else {return}
        
        if realm.objects(Schedule.self).isEmpty {
            let allExercises = realm.objects(Exercise.self)
            var schedules: [Schedule] = []
            
            var date = DateComponents(calendar: Calendar.current, year: 2024, month: 6, day: 1).date!
            let endDate = DateComponents(calendar: Calendar.current, year: 2024, month: 9, day: 5).date!
            
            while date <= endDate {
                var scheduleExercises: [ScheduleExercise] = []
                
                for i in 0..<3 {
                    guard let exercise = allExercises.randomElement() else {return}
                    
                    let weights = [10,20,30,40,50,60,70,80,90,100]
                    
                    let sets = [
                        ScheduleExerciseSet(order: 1, weight: weights.randomElement() ?? 60, reps: 10, isCompleted: Bool.random()),
                        ScheduleExerciseSet(order: 2, weight: weights.randomElement() ?? 60, reps: 10, isCompleted: Bool.random()),
                        ScheduleExerciseSet(order: 3, weight: weights.randomElement() ?? 60, reps: 10, isCompleted: Bool.random()),
                    ]
                    
                    let scheduleExercise = ScheduleExercise(exercise: exercise, order: i+1, isCompleted: Bool.random(), sets: sets)
                    scheduleExercises.append(scheduleExercise)
                }
                let schedule = Schedule(date: date, exercises: scheduleExercises)
                schedules.append(schedule)
                
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                
            }
            
            do {
                try realm.write {
                    realm.add(schedules)
                }
                
                print("6~9월 Schedule 샘플 데이터를 추가하였습니다.")
            } catch {
                print("6~9월 Schedule 샘플 데이터를 추가에 실패했습니다. \(error)")
            }
        }
        
        else {
            print("6~9월 Schedule 샘플 데이터가 이미 존재합니다.")
        }
    }
    
    func addInBodySampleData() {
        guard let realm = realm else {return}
        
        var sampleData = [InBody]()
        
        for day in 1...14 {
            let date = makeDate(year: 2024, month: 7, day: day)
            let weight = Float.random(in: 50...70)
            let bodyFat = Float.random(in: 10...25)
            let muscleMass = Float.random(in: 20...40)
            
            let inBody = InBody(date: date, weight: weight, bodyFat: bodyFat, muscleMass: muscleMass)
            sampleData.append(inBody)
        }
        
        
        for day in 5...31 {
            let date = makeDate(year: 2024, month: 8, day: day)
            let weight = Float.random(in: 60...90)
            let bodyFat = Float.random(in: 10...25)
            let muscleMass = Float.random(in: 20...40)
            
            let inBody = InBody(date: date, weight: weight, bodyFat: bodyFat, muscleMass: muscleMass)
            sampleData.append(inBody)
        }
        
        for day in 1...3 {
            let date = makeDate(year: 2024, month: 9, day: day)
            let weight = Float.random(in: 60...90)
            let bodyFat = Float.random(in: 10...25)
            let muscleMass = Float.random(in: 20...40)
            
            let inBody = InBody(date: date, weight: weight, bodyFat: bodyFat, muscleMass: muscleMass)
            sampleData.append(inBody)
        }
        
        if realm.objects(InBody.self).isEmpty {
            try! realm.write {
                realm.add(sampleData)
                print("인바디 샘플 데이터를 추가하였습니다.")
            }
        }
    }
    
    func makeDate(year: Int, month: Int, day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
    
}
