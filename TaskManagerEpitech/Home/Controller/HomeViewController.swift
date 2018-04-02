//
//  HomeViewController.swift
//  TaskManagerEpitech
//
//  Created by Valentin Limagne on 15/02/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var UserConnectedBtn: UIButton!
    @IBOutlet weak var ToDoView: UIView!
    @IBOutlet weak var DoLaterView: UIView!
    @IBOutlet weak var DelegateView: UIView!
    @IBOutlet weak var EliminateView: UIView!
    @IBOutlet weak var ToDoLbl: UILabel!
    @IBOutlet weak var DoLaterLbl: UILabel!
    @IBOutlet weak var DelegateLbl: UILabel!
    @IBOutlet weak var EliminateLbl: UILabel!
    
    let ref = Database.database().reference(withPath: "tasks-items")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initApp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initApp()
        
    }
    
    func initApp() {
        let LevelList = ["Do First", "Do Later", "Delegate", "Eliminate"]
        
        for item in LevelList {
            ref.queryOrdered(byChild: "level").queryEqual(toValue: item).observeSingleEvent(of: .value, with: { snapshot in
                self.formatedButton(str: "\(snapshot.childrenCount)", item: item)
            })
        }
        
        ToDoView.addGestureRecognizer(setGestureRecognizer())
        DoLaterView.addGestureRecognizer(setGestureRecognizer())
        DelegateView.addGestureRecognizer(setGestureRecognizer())
        EliminateView.addGestureRecognizer(setGestureRecognizer())
    }
    
    func setGestureRecognizer() -> UITapGestureRecognizer {
        var panRecognizer = UITapGestureRecognizer()
        
        panRecognizer = UITapGestureRecognizer (target: self, action: #selector(tapAction(_:)))
        return panRecognizer
    }
    
    @objc func tapAction(_ gestureRecognizer: UITapGestureRecognizer) {
        let taskVC = TaskViewController()
        if (gestureRecognizer.view?.tag == 0) {
            taskVC.tvalue = "Do First"
        } else if (gestureRecognizer.view?.tag == 1) {
            taskVC.tvalue = "Do Later"
        } else if (gestureRecognizer.view?.tag == 2) {
            taskVC.tvalue = "Delegate"
        } else if (gestureRecognizer.view?.tag == 3) {
            taskVC.tvalue = "Eliminate"
        }
        taskVC.tchild = "level"
        self.show(taskVC, sender: self)
    }
    
    @IBAction func NewTaskBtnAction(_ sender: UIButton) {
        let vc = NewTaskViewController()
        self.show(vc, sender: self)
    }
    
    func formatedButton(str: String, item: String) {
        if (item == "Do First") {
            self.ToDoLbl.text = str
        } else if (item == "Do Later") {
            self.DoLaterLbl.text = str
        }else if (item == "Delegate") {
            self.DelegateLbl.text = str
        }else if (item == "Eliminate") {
            self.EliminateLbl.text = str
        }
    }
    
    @IBAction func userBtn(_ sender: Any) {
        let vc = UserViewController()
        self.show(vc, sender: self)
    }
}
