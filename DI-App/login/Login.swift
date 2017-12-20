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
        
        rememberMeButton.layer.borderWidth = 1
        rememberMeButton.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

