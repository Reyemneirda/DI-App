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
        userIsConnected()
        checkIfUserIsin()
        // Do any additional setup after loading the view.
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
            
            self.performSegue(withIdentifier: "IsNotConnected", sender: self)
        }
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
