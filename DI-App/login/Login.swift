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
    
    @IBOutlet weak var usertxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logReg: UISegmentedControl!
    @IBOutlet weak var goIn: UIButton!
    @IBOutlet weak var registerForm: UIStackView!
    @IBOutlet weak var registerFormLeading: NSLayoutConstraint!
    
    @IBOutlet weak var registerFormTrailing: NSLayoutConstraint!
    @IBOutlet weak var seePassword: UIButton!
    
    
    @IBAction func rememberMe(_ sender: UIButton)
    {
    }
    
    
    @IBAction func IseePass(_ sender: UIButton)
    {
        
        if passwordTextField.isSecureTextEntry == true {
            seePassword.isSelected = true
            passwordTextField.isSecureTextEntry = false
        } else {
            seePassword.isSelected = false
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    func handleRegister()
    {
        
        guard let name = usertxtField.text, let email = emailTxtField.text, let password = passwordTextField.text else {return}
        if logReg.selectedSegmentIndex == 1 {
            
            Auth.auth().createUser(withEmail: email, password: password, completion:
                { [weak self]  (user, error)   in
                    if error != nil
                    {
                        
                        print(error)
                        
                        return
                    }
                    guard let uid = user?.uid else {
                        return
                    }
                    
                 let ref = Database.database().reference(fromURL: "https://di-app-14896.firebaseio.com/")
                    let userReference = ref.child("students").child(uid)
                    let user = ["name": name, "email": email]
                    userReference.updateChildValues(user, withCompletionBlock: { (err, ref) in
                        if err != nil
                        {
                            print(err)
                            
                            return
                        }
                        print("\n User Saved Succesfully \n")

                    })

                    self?.performSegue(withIdentifier: "FirstSignIN", sender: self)
                    //success
            })
        } else  if logReg.selectedSegmentIndex == 0 {
            Auth.auth().signIn(withEmail: email, password: password, completion:
                { [weak self] (user, error)  in
                    if error != nil
                    {
                       
                        print(error)
                        return
                    }
                    self?.performSegue(withIdentifier: "FirstSignIN", sender: self)
                    
                    //success
            })
        }
        
    }
    
   @IBAction func textFieldAppearing()
    {
        let title = logReg.titleForSegment(at: logReg.selectedSegmentIndex)
        if logReg.selectedSegmentIndex == 0
        {
            goIn.setTitle(title, for: .normal)
            usertxtField.isHidden = true
            
        } else if logReg.selectedSegmentIndex == 1
        {
            mainView.backgroundColor = UIColor.white
            goIn.setTitle(title, for: .normal)
            usertxtField.isHidden = false

        }
    }
    
    
    @IBAction func SignIN(_ sender: Any) {
        
        handleRegister()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://di-app-14896.firebaseio.com/")
        
        textFieldAppearing()
        rememberMeButton.layer.borderWidth = 1
        rememberMeButton.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func registerFail()
    {
        self.registerFormLeading.constant = self.registerFormTrailing.constant;
        self.registerFormTrailing.constant = 0
        
        UIStackView.animate(withDuration: 2.0) {
            self.view.layoutIfNeeded() // resets the view rendering; creating the display for the user to look at
        }
        
        var email = emailTxtField.text
        var password = passwordTextField.text
        email = ""
        password = ""
    }

}

