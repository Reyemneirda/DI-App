//
//  ViewController.swift
//  DI-App
//
//  Created by Adrien Meyer on 20/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Login: BaseViewController {

    @IBOutlet weak var rememberMeButton: UIButton!
    
    @IBAction func rememberMe(_ sender: UIButton)
    {
    }
    
    
    
    @IBAction func SignIN(_ sender: Any) {
        performSegue(withIdentifier: "FirstSignIN", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://di-app-14896.firebaseio.com/")
        
        
        rememberMeButton.layer.borderWidth = 1
        rememberMeButton.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

