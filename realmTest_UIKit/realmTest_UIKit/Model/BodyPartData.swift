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
}

struct ExerciseSets {
    let name: String
    var setsCount: Int
}
