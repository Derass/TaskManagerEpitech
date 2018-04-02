//
//  TaskItem.swift
//  TaskManagerEpitech
//
//  Created by Valentin Limagne on 16/02/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct TaskItem {
    
    let key : String
    let id: String
    let name : String
    let description : String
    let level: String
    let addedUser : String
    let ref : DatabaseReference!
    var completed: Bool
    let asignedUser: String
    
    init(key: String = "", id: String, name: String, description: String, level: String, addedUser: String, completed: Bool, asignedUser: String) {
        self.key = key
        self.id = id
        self.name = name
        self.description = description
        self.level = level
        self.addedUser = addedUser
        self.completed = completed
        self.ref = nil
        self.asignedUser = asignedUser
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        id = snapshotValue["id"] as! String
        name = snapshotValue["name"] as! String
        description = snapshotValue["description"] as! String
        level = snapshotValue["level"] as! String
        addedUser = snapshotValue["addedByUser"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
        asignedUser = snapshotValue["asignedUser"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "id": id,
            "name": name,
            "description": description,
            "level": level,
            "addedByUser": addedUser,
            "completed": completed,
            "asignedUser": asignedUser
        ]
    }
}
