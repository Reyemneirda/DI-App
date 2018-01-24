//
//  Landpage.swift
//  DI-App
//
//  Created by Adrien Meyer on 09/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit
import Firebase

class Landpage: BaseViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loggedOut"), object: nil, queue: nil) { (notif)  in
            self.loadOptions()
        }
        loadOptions()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    func loadOptions() {
        getEventsForCalendar()
        userIsConnected()
    }
    func userIsConnected()
    {
        if Auth.auth().currentUser?.uid != nil
        {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("students").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                self.performSegue(withIdentifier: "isConnected", sender: self)
                
            }, withCancel: nil)
            
            
        } else {
            DispatchQueue.main.async {
                print("Not connected")
                self.performSegue(withIdentifier: "IsNotConnected", sender: self)
            }
            
            
        }
    }
    
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
