//
//  Task.swift
//  realmTest_swiftUI
//
//  Created by wonyoul heo on 8/20/24.
//

import Foundation
import RealmSwift


class Task: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var completed = false
}

