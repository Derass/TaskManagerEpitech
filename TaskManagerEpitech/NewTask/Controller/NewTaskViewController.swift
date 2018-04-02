//
//  NewTaskViewController.swift
//  TaskManagerEpitech
//
//  Created by Valentin Limagne on 16/02/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class NewTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var Picker: UIPickerView!
    @IBOutlet weak var ErrorView: UIView!
    @IBOutlet weak var errorLbl: UILabel!
    var user: String!
    var DataPicker: [String] = [String]()
    var level: String!
    
    let titleLimit = 50
    let descriptionLimit = 500
    
    let ref = Database.database().reference(withPath: "tasks-items")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTF.delegate = self
        self.descriptionTF.delegate = self
        self.Picker.delegate = self
        self.Picker.dataSource = self
        self.user = Auth.auth().currentUser!.email
        
        DataPicker = ["Do First", "Do Later", "Delegate", "Eliminate"]
        Picker.selectedRow(inComponent: 0)
        
        //Set default Level
        self.level = "Do First"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.level = DataPicker[row]
    }
    
    @IBAction func finishBtn(_ sender: UIButton) {
        if (titleTF.text == "") {
            ErrorView.backgroundColor = UIColor.red
            errorLbl.text = "Champs titre vide"
            ErrorView.isHidden = false
        } else if (descriptionTF.text == "") {
            ErrorView.backgroundColor = UIColor.red
            errorLbl.text = "Champs Description vide"
            ErrorView.isHidden = false
        } else {
            ErrorView.isHidden = true
            let random = "\(arc4random())"
            let taskItem = TaskItem(id: random, name: titleTF.text!, description: descriptionTF.text!, level: level, addedUser: user, completed: false, asignedUser: "")
            let taskItemRef = self.ref.child(random)
            taskItemRef.setValue(taskItem.toAnyObject())
            
            let vc = HomeViewController()
            self.show(vc, sender: self)
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTF {
            descriptionTF.becomeFirstResponder()
        }
        if textField == descriptionTF {
            textField.resignFirstResponder()
        }
        return true
    }
}
