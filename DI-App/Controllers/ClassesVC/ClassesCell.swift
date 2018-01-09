//
//  ClassesCell.swift
//  DI-App
//
//  Created by Adrien Meyer on 08/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit

class ClassesCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var teacher: UILabel!
    
    @IBOutlet weak var classDescription: UITextView!
    
    
    func updateCourses(classes: Courses)
    {
        self.title.text = classes.name
        self.teacher.text = classes.teacher
        self.classDescription.text = classes.descritpion
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
