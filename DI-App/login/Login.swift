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
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logReg: UISegmentedControl!
    @IBOutlet weak var goIn: UIButton!
    @IBOutlet weak var registerForm: UIStackView!
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
                        self?.registerFail()
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
                        self?.registerFail()
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
            emailTxtField.isHidden = false
            passwordTextField.isHidden = false
            
        } else if logReg.selectedSegmentIndex == 1
        {
            goIn.setTitle(title, for: .normal)
            usertxtField.isHidden = false
            emailTxtField.isHidden = false
            passwordTextField.isHidden = false

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
        
        
        
        self.containerView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.containerView.frame.size.height) // only to scroll up and down
        
        self.scrollView.contentSize = self.containerView.frame.size // allows the scrollview to actually scroll
        
        self.scrollView.addSubview(self.containerView)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func youFailHard()
   {
    
    let alertView = UIAlertController(title: "Error", message: "Invalid Email or Password", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
    alertView.addAction(okAction)
    
    
    self.present(alertView, animated: true, completion: nil)
    }

    
    func registerFail()
    {
        let time = DispatchTime(uptimeNanoseconds: 1000000000)
        self.registerForm.shake()
        self.emailTxtField.text = ""
        self.passwordTextField.text = ""
        self.usertxtField.text = ""
        
        DispatchQueue.main.asyncAfter(deadline: time) {
             self.youFailHard()
        }
    }

}

