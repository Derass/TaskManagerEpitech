//
//  UserViewController.swift
//  TaskManagerEpitech
//
//  Created by Developpeur on 30/03/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import FirebaseAuth

class UserViewController: UIViewController {
    
    @IBOutlet weak var emailLbl: UILabel!
    var items: [TaskItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailLbl.text = Auth.auth().currentUser?.email
    }

    @IBAction func myTaskBtn(_ sender: Any) {
        let vc = TaskViewController()
        vc.tvalue = (Auth.auth().currentUser?.email)!
        vc.tchild = "asignedUser"
        self.show(vc, sender: self)
    }
    
    @IBAction func disconnectBtn(_ sender: Any) {
     try! Auth.auth().signOut()
        let vc = LoginViewController()
        self.show(vc, sender: self)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
