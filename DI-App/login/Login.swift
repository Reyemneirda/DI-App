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
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logReg: UISegmentedControl!
    @IBOutlet weak var goIn: UIButton!
    @IBOutlet weak var registerForm: UIStackView!
    @IBOutlet weak var seePassword: UIButton!
    @IBOutlet weak var linkedIn: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var sessionCity: UITextField!
    @IBOutlet weak var program: UITextField!
    @IBOutlet weak var programs: UIPickerView!
    
    var ListPrograms = ["Mobile Development","Web Development"]
    
    @IBOutlet weak var projects: UITextView!
    @IBOutlet weak var hobbies: UITextView!
    
    @IBOutlet weak var cities: UIPickerView!
    var listCities = ["Jerusalem","Tel-Aviv"]
    
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
        
        guard let firstName = firstName.text,
            let lastName = lastName.text,
            let linkedIN = linkedIn.text,
            let email = emailTxtField.text,
            let phone = phoneNumber.text,
            let sessionCity = sessionCity.text,
            let sessionProgram = program.text,
            let hobbies = hobbies.text,
            let project = projects.text,
            let password = passwordTextField.text else {return}
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
                    let user = ["name": "\(firstName) \(lastName)",
                        "email": email,
                        "linkedIn": linkedIN,
                        "phone": phone,
                        "session": "\(sessionCity): \(sessionProgram)",
                        "hobby": hobbies,
                        "projects": project]
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
            
           firstName.isHidden = true
            lastName.isHidden = true
            linkedIn.isHidden = true
            emailTxtField.isHidden = false
//            emailTxtField.frame.size = CGSize(height: 45)
            phoneNumber.isHidden = true
            sessionCity.isHidden = true
            program.isHidden = true
            hobbies.isHidden = true
            projects.isHidden = true
            passwordTextField.isHidden = false
//            passwordTextField.frame.size = CGSize(height: 45)
            cities.isHidden = true
            programs.isHidden = true
            
            self.containerView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            
            theySeeMeScrolling()
            
        } else if logReg.selectedSegmentIndex == 1
        {
            goIn.setTitle(title, for: .normal)
            firstName.isHidden = false
            lastName.isHidden = false
            linkedIn.isHidden = false
            emailTxtField.isHidden = false
            phoneNumber.isHidden = false
            sessionCity.isHidden = false
            program.isHidden = false
            hobbies.isHidden = false
            projects.isHidden = false
            passwordTextField.isHidden = false
            cities.isHidden = true
            programs.isHidden = true
            
            self.containerView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: 756)
          theySeeMeScrolling()

        }
    }
    
    func theySeeMeScrolling()
    {
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.containerView.frame.size.height) // only to scroll up and down
        
        self.scrollView.contentSize = self.containerView.frame.size // allows the scrollview to actually scroll
        
        self.scrollView.addSubview(self.containerView)
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
        
     theySeeMeScrolling()
        
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
        firstName.text = ""
        lastName.text = ""
        linkedIn.text = ""
        emailTxtField.text = ""
        phoneNumber.text = ""
        sessionCity.text = ""
        program.text = ""
        hobbies.text = ""
        projects.text = ""
        passwordTextField.text = ""
        DispatchQueue.main.asyncAfter(deadline: time) {
             self.youFailHard()
        }
    }
 
}

