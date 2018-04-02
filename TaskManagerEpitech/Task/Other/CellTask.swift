//
//  CellTask.swift
//  TaskManagerEpitech
//
//  Created by Developpeur on 22/03/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import Foundation
import UIKit

class CellTask: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var assigneLbl: UILabel!
    @IBOutlet weak var etatImg: UIImageView?
    
    override func awakeFromNib() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true);
    }
}
