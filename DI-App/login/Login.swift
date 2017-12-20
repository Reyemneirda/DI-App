//
//  ViewController.swift
//  DI-App
//
//  Created by Adrien Meyer on 20/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit

class Login: BaseViewController {

    @IBOutlet weak var rememberMeButton: UIButton!
    
    @IBAction func rememberMe(_ sender: UIButton)
    {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rememberMeButton.layer.borderWidth = 1
        rememberMeButton.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

