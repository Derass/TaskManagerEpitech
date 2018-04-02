//
//  TaskDetailController.swift
//  TaskManagerEpitech
//
//  Created by Developpeur on 22/03/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TaskDetailViewController: UIViewController {
    
    var dict : NSDictionary!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ContentLbl: UILabel!
    @IBOutlet weak var AddedByLbl: UILabel!
    @IBOutlet weak var asignedUser: UILabel!
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    
    var item: [TaskItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLbl.text = item[0].name
        self.AddedByLbl.text = "Added by \(item[0].addedUser)"
        self.asignedUser.text = "Assigned to \(item[0].asignedUser)"
        self.ContentLbl.text = item[0].description

        if (item[0].asignedUser != "") {
            takeButton.isEnabled = false
        }
        if (item[0].completed == true || item[0].asignedUser == "") {
            completedButton.isEnabled = false
        }
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TakeTaskBtn(_ sender: Any) {
        let email = Auth.auth().currentUser?.email
        item[0].ref?.updateChildValues(["asignedUser": email!])
        self.asignedUser.text = "Assigned to \(email!)"
        self.takeButton.isEnabled = false
        self.completedButton.isEnabled = true
    }
    //
    @IBAction func DeleteTaskBtn(_ sender: Any) {
        item[0].ref?.updateChildValues(["completed": true])
        self.completedButton.isEnabled = false
        
    }
}
