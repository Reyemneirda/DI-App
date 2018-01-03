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

class SideMenuViewController: BaseViewController
{
    let sideMenu = SideMenuManager()
    let customSideMenuManager = SideMenuManager()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logMeOut(_ sender: Any)
    {
        
        handleLogOut()
        
    }
    
    
    func handleLogOut()
    {
        if Auth.auth().currentUser?.uid == nil
        {
            do
            {
                try Auth.auth().signOut()
                
            } catch let logOutError
            {
                print(logOutError)
            }
        }
        self.tabBarController?.dismiss(animated: true, completion: nil)
        
        //        let loginController = Login()
        //       self.present(loginController, animated: true, completion: nil)
    }
    
    func checkIfUserIsin()
    {
        if Auth.auth().currentUser?.uid == nil
        {
            handleLogOut()
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("students").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionnary = snapshot.value as? [String : AnyObject] {
//                    self.hello.text = dictionnary["name"] as! String?
                    
                }
                
            }, withCancel: nil)
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
