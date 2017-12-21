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
    
    @IBOutlet weak var logReg: UISegmentedControl!
    @IBOutlet weak var usertxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func rememberMe(_ sender: UIButton)
    {
    }
    
    
    func handleRegister()
    {
       
//        guard let email = emailTxtField.text, let password = passwordTextField.text else {return}
//         if logReg.selectedSegmentIndex == 0 {
//
//        Auth.auth().createUser(withEmail: email, password: password, completion:
//            {  (user, error)  in
//            if error != nil
//            {
//                print(error)
//                return
//            }
//                self.performSegue(withIdentifier: "FirstSignIN", sender: self)
                //success
//            })
//        } else  if logReg.selectedSegmentIndex == 1 {
//            Auth.auth().signIn(withEmail: email, password: password, completion:
//                { (user, error) in
//                    if error != nil
//                    {
//                        print(error)
//                        return
//                    }
//                    self.performSegue(withIdentifier: "FirstSignIN", sender: self)
//
//                    //success
//            })
//         }
        
    }
    @IBAction func SignIN(_ sender: Any) {
        
        handleRegister()
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

