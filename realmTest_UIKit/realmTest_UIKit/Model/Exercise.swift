//
//  Exercise.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/20/24.
//

import RealmSwift
import Foundation

class Exercise: Object {
    @Persisted(primaryKey: true) var id: ObjectId // 운동의 고유 ID
    @Persisted var name: String // 운동 이름
    @Persisted var bodyParts: List<BodyPart>  // 운동 부위 - 부위 이름
    @Persisted var descriptionText: String = "" // 운동 설명 (옵션)
    @Persisted var image: Data? = nil // 운동 이미지 (옵션)
    @Persisted var totalReps: Int = 0 // 총 운동 횟수 (옵션)
    @Persisted var recentWeight: Int = 0 // 최근 무게 (옵션)
    @Persisted var maxWeight: Int = 0 // 최대 무게 (옵션)
    @Persisted var isCustom: Bool = false // 운동 커스텀 여부
}
