//
//  RealmManager.swift
//  realmTest_swiftUI
//
//  Created by wonyoul heo on 8/20/24.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: Results<Task>? = nil
    
    
    // RealmManger 클래스를 initialize 할 때 마다 openRealm이 실행 됨
    init() {
        openRealm()
        getTasks()
        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
            
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    // create read update delete
    
    func addTask(taskTitle: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                    localRealm.add(newTask)
                    
                    // add 할 때마다 업데이트
                    getTasks()
                    
                    print("Added new task to realm: \(newTask)")
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    func getTasks() {
        if let localRealm = localRealm {
                    // 결과를 바로 `tasks`에 할당
                    tasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
                }
    }
    
    
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                
                // 업데이트 할 것이 없다면 넘어가라
                guard !taskToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("Updated task with id \(id)! Completed status: \(completed)")
                }
                
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
            
    }
    
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            
            do {
                if let taskToDelete = localRealm.object(ofType: Task.self, forPrimaryKey: id) {
                    
                    
                    try localRealm.write {
                        localRealm.delete(taskToDelete)
                        print("Delete task with id \(id)")
                    }
                    
                    
                    
                } else {
                    print("No task found with id \(id)")

                }
                
            } catch {
                print("Error deleting task \(id) to Realm: \(error)")

            }
        }
    }
    
    
}
