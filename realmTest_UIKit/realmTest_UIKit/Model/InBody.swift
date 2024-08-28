//
//  InBody.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/21/24.
//

import Foundation
import RealmSwift

class InBody: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId // 고유 ID
    @Persisted var date: Date // 날짜
    @Persisted var weight: Float // 몸무게
    @Persisted var bodyFat: Float // 체지방
    @Persisted var muscleMass: Float // 골격근량
    
    convenience init(date: Date, weight: Float, bodyFat: Float, muscleMass: Float) {
        self.init()
        
        self.date = date
        self.weight = weight
        self.bodyFat = bodyFat
        self.muscleMass = muscleMass
    }
}
