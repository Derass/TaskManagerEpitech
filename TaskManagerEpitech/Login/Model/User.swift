//
//  User.swift
//  TaskManagerEpitech
//
//  Created by Valentin Limagne on 15/02/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import Foundation
import FirebaseAuth

struct UserS {
    let uid: String
    let email: String
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
