//
//  Task.swift
//  realmTest_swiftUI
//
//  Created by wonyoul heo on 8/20/24.
//

import Foundation
import RealmSwift


struct TodoTask: Identifiable, Codable {
    var id = UUID().uuidString
    let title: String
    let completed: Bool
    
    init(id: String = UUID().uuidString, title: String, completed: Bool) {
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    init(todoObj: Task) {
        self.id = todoObj.id.stringValue
        self.title = todoObj.title
        self.completed = todoObj.completed
    }
}



// 데이터베이스용 object
class Task: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var completed: Bool = false
}
