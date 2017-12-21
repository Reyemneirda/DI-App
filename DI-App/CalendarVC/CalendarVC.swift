//
//  CalendarVC.swift
//  DI-App
//
//  Created by Gabriel Drai on 20/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class CalendarVC: BaseViewController {

    
    @IBOutlet weak var hello: UILabel!
    
    func printHelloUser()
    {
        
     let ref = Database.database().reference(fromURL: "https://di-app-14896.firebaseio.com/")
        let user = Auth.auth().currentUser?.displayName
        hello.text = "Hello\(String(describing: user))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printHelloUser()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
