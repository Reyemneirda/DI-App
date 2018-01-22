//
//  File.swift
//  DI-App
//
//  Created by Gabriel Drai on 21/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import Foundation
import Firebase

class DBmanage {
func getEventsForCalendar() {

    var ref: DatabaseReference!
    
    ref = Database.database().reference()
    let useruid = Auth.auth().currentUser?.uid
    let coursesDBref = ref.child("Courses")
    
    coursesDBref.observeSingleEvent(of: .value) { (snapshot) in
        print(snapshot)
    }


}
}



