//
//  Schedule.swift
//  MVVMTest
//
//  Created by wonyoul heo on 9/2/24.
//

import RealmSwift
import Foundation


class Schedule: Object {
    @Persisted(primaryKey: true) var id: ObjectId // 고유 ID
    @Persisted var date: Date // 날짜
    @Persisted var exercises: List<ScheduleExercise> // 운동 리스트 1:M
    
    convenience init(date: Date, exercises: [ScheduleExercise]/*, highlightedBodyParts: [HighlightedBodyPart]*/) {
        self.init()
        self.date = date
        self.exercises.append(objectsIn: exercises)
    }
}

class ScheduleExercise: Object {
    @Persisted(primaryKey: true) var id: ObjectId // 고유 ID
    @Persisted var exercise: Exercise? // 운동 - id, 이름, 부위
    @Persisted var order: Int // 운동 순서
    @Persisted var isCompleted: Bool // 운동 완료 여부
    @Persisted var sets: List<ScheduleExerciseSet> // 운동 세트
    
    convenience init(exercise: Exercise, order: Int, isCompleted: Bool, sets: [ScheduleExerciseSet]) {
        self.init()
        self.exercise = exercise
        self.order = order
        self.isCompleted = isCompleted
        self.sets.append(objectsIn: sets)
    }
}

class ScheduleExerciseSet: EmbeddedObject {
//    @Persisted(primaryKey: true) var id: ObjectId // 고유 ID
    @Persisted var order: Int // 세트 순서
    @Persisted var weight: Int // 무게
    @Persisted var reps: Int // 횟수
    @Persisted var isCompleted: Bool // 세트 완료 여부
    
    convenience init(order: Int, weight: Int, reps: Int, isCompleted: Bool) {
        self.init()
        self.order = order
        self.weight = weight
        self.reps = reps
        self.isCompleted = isCompleted
    }
}
