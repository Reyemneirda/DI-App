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

class SideMenuViewController: UIViewController,UISideMenuNavigationControllerDelegate
{
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        // loading xib file of the subclass's name and then adding it to self.view from self.mainView
        
        let mainBundle = Bundle.main // the packet of all of the information inside the application such as the storyboard, xibs, pictures, and other multimedia.
        
        if let nibName:String = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
            /* name was originally "CaseStudy.ViewController" -> components(seperatedBy: ".") = ["CaseStudy","ViewController"] -> components(seperatedBy:".").last == "ViewController"
             */
        {
            print(nibName) // printing the sanitized name
            
            mainBundle.loadNibNamed(nibName, owner: self, options: nil) // loading the xib file
            
            if( self.mainView != nil )
            {
                self.mainView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
                
                self.mainView.frame = self.view.bounds
                
                self.view.addSubview(self.mainView)
            }
        }
    }
    
    func handleLogOut()
    {
        if Auth.auth().currentUser?.uid != nil
        {
            do
            {
                try Auth.auth().signOut()
                
            } catch let logOutError as NSError
            {
                print ("Error signing out: %@", logOutError)
            }
            
            guard let presenter : UIViewController = self.presentingViewController
                else
            {
                self.dismiss(animated: true, completion: nil)
                return
            }
            
            self.dismiss(animated: true, completion: {
                
                presenter.dismiss(animated: true, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name("loggedOut"), object: nil)
                })
            })
        }
        else
        {
            print("doodooo head")
        }
    }
    
    
    
    func checkIfUserIsin()
    {
        if Auth.auth().currentUser?.uid == nil
        {
            handleLogOut()
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("students").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                
            }, withCancel: nil)
        }
    }
    
    @IBAction func logMeOut(_ sender: Any)
    {
        handleLogOut()
    }
    
    @IBAction func goToMyClandar(_ sender: UIButton)
    {
        print("fffff")
        
    }
    
}
