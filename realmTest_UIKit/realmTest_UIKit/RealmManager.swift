//
//  RealmManager.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/21/24.
//

import RealmSwift
import Foundation

class RealmManager: ObservableObject {
    static let shared = RealmManager()
    private(set) var localRealm: Realm?
    
    @Published private(set) var inbodyInfos: Results<InBody>? = nil
    
    init() {
        if let realmFileURL = Realm.Configuration.defaultConfiguration.fileURL {
            print("open \(realmFileURL)")
        }
        openRealm()
        
        
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
    
    func addInbody(weight: Float, bodyFat: Float, muscleMass: Float) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newInbodyInfo = InBody(value: ["weight": weight, "bodyFat": bodyFat, "muscleMass": muscleMass ])
                    localRealm.add(newInbodyInfo)
                    print("Added new Inbody Info")
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    func getInbodyInfo() {
        if let localRealm = localRealm {
            inbodyInfos = localRealm.objects(InBody.self).sorted(byKeyPath: "date")
        }
    }
    
}



