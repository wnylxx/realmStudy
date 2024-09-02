//
//  BodyPart.swift
//  MVVMTest
//
//  Created by wonyoul heo on 9/2/24.
//

import RealmSwift

enum BodyPart: String, PersistableEnum {
    case chest = "가슴"
    case back = "등"
    case shoulders = "어깨"
    case triceps = "삼두"
    case biceps = "이두"
    case abs = "복근"
    case quadriceps = "전면 허벅지"
    case hamstrings = "후면 허벅지"
    case glutes = "엉덩이"
    case adductors = "내전근"
    case abductors = "외전근"
    case calves = "종아리"
    case trap = "승모근"
    case forearms = "전완근"
    case other = "기타"
}
