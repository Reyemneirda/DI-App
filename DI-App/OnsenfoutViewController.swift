//
//  OnsenfoutViewController.swift
//  DI-App
//
//  Created by Adrien Meyer on 21/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class OnsenfoutViewController: BaseViewController {

    @IBOutlet weak var hello: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsin()
        // Do any additional setup after loading the view.
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
