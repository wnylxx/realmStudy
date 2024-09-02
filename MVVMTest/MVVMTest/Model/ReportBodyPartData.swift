//
//  ReportBodyPartData.swift
//  MVVMTest
//
//  Created by wonyoul heo on 9/2/24.
//

import Foundation

struct ReportBodyPartData {
    let bodyPart: String
    var totalSets: Int
    var exercises: [ExerciseSets]
    var isStackViewVisible: Bool = false // 기본값: 안보이기
}

struct ExerciseSets {
    let name: String
    var setsCount: Int
    var daysCount: Int
    var minWeight: Int
    var maxWeight: Int
}
