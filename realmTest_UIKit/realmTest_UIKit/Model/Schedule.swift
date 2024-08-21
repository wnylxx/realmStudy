//
//  Schedule.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/20/24.
//

import Foundation
import RealmSwift

class Schedule: Object {
    @Persisted(primaryKey: true) var id: ObjectId // 고유 ID
    @Persisted var date: Date // 날짜
    @Persisted var exercises: List<ScheduleExercise> // 운동 리스트 1:M
//    @Persisted var highlightedBodyParts: List<HighlightedBodyPart> // 부위 색칠 1:M - 부위,단계
    
    // 고유 id
    // 9월 11일
    // [ (id: 이름: 데드리프트 부위: 등) 순서: 1 완료: true,
    //             sets - 순서: 1, 무게: 30, 횟수: 10, 완료: bool   ,
    //             sets - 순서: 2, 무게: 40, 횟수: 10, 완료: bool   ,
    //  숄더프레스]
    // [등, 어깨]
    
    convenience init(date: Date, exercises: [ScheduleExercise] /*, highlightedBodyParts: [HighlightedBodyPart]*/) {
        self.init()
        self.date = date
        self.exercises.append(objectsIn: exercises)
//        self.highlightedBodyParts.append(objectsIn: highlightedBodyParts)
    }
}

class ScheduleExercise: Object {
    @Persisted(primaryKey: true) var id: ObjectId // 고유 ID
    @Persisted var exercise: Exercise? // 운동 - id, 이름, 부위 <- 이거 없으면 안되잖아. 근데 옵셔널 해제하면 에러 생김
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
    @Persisted var order: Int // 세트 순서
    @Persisted var weight: Int // 무게
    @Persisted var reps: Int // 횟수
    @Persisted var isCompleted: Bool // 세트 완료 여부 // 체크 를 누르면
    
    convenience init(order: Int, weight: Int, reps: Int, isCompleted: Bool) {
        self.init()
        self.order = order
        self.weight = weight
        self.reps = reps
        self.isCompleted = isCompleted
    }
    
}


//class HighlightedBodyPart : Object {
//    @Persisted(primaryKey: true) var id: ObjectId // 고유 ID
//    @Persisted var bodyPart: BodyPart? // 부위 1:1
//    @Persisted var totalSets: Int // 총 세트 수
//    
//    convenience init(bodyPart: BodyPart, totalSets: Int) {
//        self.init()
//        self.bodyPart = bodyPart
//        self.totalSets = totalSets // 등 : 8
//        // 단계 계산해서 값으로 넣자 //
//        
//        // 화면에 뿌릴때 토탈 샛의 기준에 따라 -> 표시되도록 하는게 낫지 않겠냐?
//        
//        // 등 운동을 3개를 진행 했으며
//        // 각 운동마다 (부위 - 몇 세트) 등 운동 3개 -> 부위 세트의 총합 -> 단계로 나눠서 -> 부위를 색칠
//        
//        
//        // 등운동 1: 4세트 v v v v // 1~5 : 1단계 6 ~10 : 2단계 // 월 단위
//        // 등운동 2: 4세트 v v v
//        // 등운동 3: 3세트 v
//        // 어깨운동 1 : 5세트 v
//        // 어꺠운동 2 : 4세트 v v v
//        
//        
//        // 등 : 8 / 어깨 : 4 -> 뷰
//        
//        // DB -> DB -> 뷰
//        // DB -> VM -> 뷰
//    }
//}
