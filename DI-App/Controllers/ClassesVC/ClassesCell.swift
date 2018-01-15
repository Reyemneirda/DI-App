//
//  ClassesCell.swift
//  DI-App
//
//  Created by Adrien Meyer on 08/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit
import Firebase

class ClassesCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var teacher: UILabel!
    
    @IBOutlet weak var coursesDescription: UILabel!
    
    
    func updateCourses(classes: Courses)
    {

        self.title.text = classes.name
        self.teacher.text = classes.teacher
        self.coursesDescription.text = classes.descritpion
      
    }
    
}
