//
//  BodyPartData.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/22/24.
//

import Foundation

struct BodyPartData {
    let bodyPart: String
    var totalSets: Int
    var exercises: [ExerciseSets]
    var isStackViewVisible: Bool = true // 초기값은 true
}

struct ExerciseSets {
    let name: String
    var setsCount: Int
}
