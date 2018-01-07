//
//  BaseViewController.swift
//  CaseStudy
//
//  Created by Eric Shorr on 22/11/2017.
//  Copyright © 2017 Developer Institute. All rights reserved.
//

import UIKit
import Firebase

class BaseViewController: UIViewController {
    
    
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
                }
                
            }, withCancel: nil)
        }
    }
    
    @IBAction func logMeOut(_ sender: Any)
    {
        
        handleLogOut()
        
    }
    
    
    

    
    //    func shake()
    //    {
    //        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    //        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    //        animation.duration = 0.6
    //        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    //        layer.add(animation, forKey: "shake")
    //    }
    
}
