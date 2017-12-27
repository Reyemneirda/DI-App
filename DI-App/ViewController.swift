//
//  ViewController.swift
//  SideMenuTest
//
//  Created by Gabriel Drai on 25/12/2017.
//  Copyright © 2017 Gabriel Drai. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    
    @IBAction func menu(_ sender: Any)
    {
        self.performSegue(withIdentifier: "menuSegue", sender: nil)
    }
    

}

