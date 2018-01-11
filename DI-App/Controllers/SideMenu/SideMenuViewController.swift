//
//  SideMenuViewController.swift
//  DI-App
//
//  Created by Gabriel Drai on 24/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import SideMenu
import Firebase

class SideMenuViewController: BaseViewController, UISideMenuNavigationControllerDelegate
{
    var sideMenu = SideMenuManager()
    let customSideMenuManager = SideMenuManager()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        sideMenu = customSideMenuManager

        // Do any additional setup after loading the view.

    }
    
 

}
