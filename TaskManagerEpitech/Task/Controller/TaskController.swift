//
//  TaskController.swift
//  TaskManagerEpitech
//
//  Created by Developpeur on 20/03/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var taskTabView: UITableView!
    var array = [Any] ()
    var dict : NSDictionary!
    var items: [TaskItem] = []
    
    var tchild: String = ""
    var tvalue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTabView.delegate = self
        taskTabView.dataSource = self
        
        self.taskTabView.register(UINib (nibName: "CellTask", bundle: nil), forCellReuseIdentifier: "cell")
        
        if (tchild == "asignedUser") {
            self.TitleLbl.text = "My Task"
        } else {
            self.TitleLbl.text = tvalue
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //self.taskTabView.reloadData()
        self.loadDataTask()
    }
    
    func loadDataTask() {
        let ref = Database.database().reference(withPath: "tasks-items")
        
        ref.queryOrdered(byChild: self.tchild).queryEqual(toValue: self.tvalue).observeSingleEvent(of: .value, with: { snapshot in
                var newItems: [TaskItem] = []

                for item in snapshot.children {
                    let taskItem = TaskItem(snapshot: item as! DataSnapshot)
                    if (taskItem.completed == true) {
                        newItems.append(taskItem)
                    } else {
                        newItems.insert(taskItem, at: 0)
                    }
                }
                
                self.items = newItems
                self.taskTabView.reloadData()
           // })
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let taskItem = items[indexPath.row]
        
        let cell = taskTabView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTask
        
        if (taskItem.completed == true) {
            cell.imageView?.image = UIImage(named: "validate_img")
        }
        
        cell.titleLbl.text = taskItem.name
        cell.contentLbl.text = taskItem.description
        cell.assigneLbl.text = "Assigned to : \(taskItem.asignedUser)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = TaskDetailViewController()
        vc.item.append(self.items[indexPath.row])

        self.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let TaskItem = items[indexPath.row]
            if (TaskItem.completed == true) {
                TaskItem.ref?.removeValue()
                self.taskTabView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
