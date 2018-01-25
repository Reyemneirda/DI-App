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


class Login: BaseViewController, UITextFieldDelegate {
    
    
    
    
    
    let setting = FirebaseConfiguration()

let meganne = SimpleSound(named: "h")

    @IBOutlet var helloBeautifulPeople: UITapGestureRecognizer!
    @IBOutlet weak var logRegister: CustomSegmentedControl!
    
    @IBOutlet weak var passwordForgotten: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var goIn: UIButton!
    @IBOutlet weak var registerForm: UIStackView!
    @IBOutlet weak var seePassword: UIButton!
    @IBOutlet weak var linkedIn: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var sessionCity: UIButton!
    @IBOutlet weak var selectProgram: UIButton!
    @IBOutlet var CitiesButton: [UIButton]!
    
    @IBOutlet var programsButtons: [UIButton]!
    
    @IBOutlet weak var chooseYourCity: UIStackView!
    
    @IBOutlet weak var chooseDiProgram: UIStackView!
    
    var ListPrograms = ["Mobile Development","Web Development"]
    
    @IBOutlet weak var projects: UITextView!
    @IBOutlet weak var hobbies: UITextView!
    
    var listCities = ["Jerusalem","Tel-Aviv"]
    
    @IBAction func iconSound() {
        print("pressed")
        meganne.play()
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
    
    
    //picker view config
    

    
        func handleRegister()
        {
            
            guard let firstName = firstName.text,
                let lastName = lastName.text,
                let linkedIN = linkedIn.text,
                let email = emailTxtField.text,
                let phone = phoneNumber.text,
                let sessionCity = sessionCity.titleLabel?.text,
                let sessionProgram = selectProgram.titleLabel?.text,
                let hobbies = hobbies.text,
                let project = projects.text,
                let password = passwordTextField.text else {return}
            if logRegister.selectedSegmentIndex == 1 {
                
                Auth.auth().createUser(withEmail: email, password: password, completion:
                    { [weak self]  (user, error)   in
                        if error != nil
                        {
                            self?.registerFail()
                            
                            print(error as Any)
                            
                            return
                        }
                        guard let uid = user?.uid else {
                            return
                        }
                        
                        
                        let ref = Database.database().reference(fromURL: "https://di-app-14896.firebaseio.com/")
                        let profileURL = "https://firebasestorage.googleapis.com/v0/b/di-app-14896.appspot.com/o/instagram-icon3.png"
                        let userReference = ref.child("students").child(uid)
                        let user = ["name": "\(firstName) \(lastName)",
                            "email": email,
                            "linkedIn": linkedIN,
                            "phone": phone,
                            "session": "\(sessionCity): \(sessionProgram)",
                            "hobby": hobbies,
                            "projects": project,
                            "Courses" : sessionProgram,
                            "profilePic": profileURL]
                        userReference.updateChildValues(user, withCompletionBlock: { (err, ref) in
                            if err != nil
                            {
                                print(err as Any)
                                
                                return
                            }
                            print("\n User Saved Succesfully \n")
                            
                        })
                        
                        self?.performSegue(withIdentifier: "FirstSignIN", sender: self)
                        //success
                })
            } else  if logRegister.selectedSegmentIndex == 0 {
                Auth.auth().signIn(withEmail: email, password: password, completion:
                    { [weak self] (user, error)  in
                        if error != nil
                        {
                            self?.registerFail()
                            print(error as Any)
                            return
                        }
                        
                        self?.performSegue(withIdentifier: "FirstSignIN", sender: self)
                        
                        //success
                })
            }
            
        }
    
 
    
    @IBAction func textFieldAppearing()
    {
        let title = logRegister.titleForSegment
        
        if logRegister.selectedSegmentIndex == 0
        {
            goIn.setTitle(title, for: .normal)
            print(goIn.titleLabel?.text)
           firstName.isHidden = true
            lastName.isHidden = true
            linkedIn.isHidden = true
            emailTxtField.isHidden = false
//            emailTxtField.frame.size = CGSize(height: 45)
            phoneNumber.isHidden = true
            chooseYourCity.isHidden = true
            chooseDiProgram.isHidden = true
            hobbies.isHidden = true
            projects.isHidden = true
            passwordTextField.isHidden = false
//            passwordTextField.frame.size = CGSize(height: 45)

            
            
            self.containerView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            
            theySeeMeScrolling()
            
        } else if logRegister.selectedSegmentIndex == 1
        {
            goIn.setTitle(title, for: .normal)
            print(goIn.titleLabel?.text)
            firstName.isHidden = false
            lastName.isHidden = false
            linkedIn.isHidden = false
            emailTxtField.isHidden = false
            phoneNumber.isHidden = false
            chooseYourCity.isHidden = false
            chooseDiProgram.isHidden = false
            hobbies.isHidden = false
            projects.isHidden = false
            passwordTextField.isHidden = false

            
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
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func viewDidLoad() {
        
      
        super.viewDidLoad()
        
        self.passwordTextField.delegate = self
        textFieldShouldReturn(passwordTextField)
        textFieldShouldReturn(emailTxtField)
        
        var ref: DatabaseReference! = Database.database().reference(fromURL: "https://di-app-14896.firebaseio.com/")
        
        textFieldAppearing()
        
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
        sessionCity.titleLabel?.text = "Select A City"
        selectProgram.titleLabel?.text = "Select Your Progam"
        hobbies.text = ""
        projects.text = ""
        passwordTextField.text = ""
        passwordForgotten.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: time) {
             self.youFailHard()
        }
    }
    
    @IBAction func handeProgramSelection(_ sender: UIButton)
    {
         guard let title = sender.currentTitle else {return}
        programsButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                
        button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    @IBAction func iForgotMyPassword(_ sender: UIButton)
    {
        guard let email = emailTxtField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
            let alertView = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alertView.addAction(okAction)
            
            
            self.present(alertView, animated: true, completion: nil)
            }
            }
    }
    
    
    
    
    enum DICourses: String
    {
        case webDev = "Web Development"
        case mobileDev = "Mobile Development"
    }
    
    
    @IBAction func selectProgram(_ sender: UIButton)
    {
        
        
        
        
        
        
        guard let title = sender.currentTitle,
            let progList = DICourses(rawValue: title)  else {
                return
        }
        
        switch progList{
        case .webDev:
            guard sessionCity.currentTitle != "Web Development" else {return}
            programsButtons.forEach { (button) in
                UIView.animate(withDuration: 0.3, animations: {
                    
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                })
                
            }
            selectProgram.setTitle(title, for: .normal)
        case .mobileDev:
            guard sessionCity.currentTitle != "Mobile Development" else {return}
            programsButtons.forEach { (button) in
                UIView.animate(withDuration: 0.3, animations: {
                    
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                })
                
            }
            selectProgram.setTitle(title, for: .normal)
        default:
            selectProgram.titleLabel?.text = title
        }
    }
    
    
    @IBAction func handleSelection(_ sender: UIButton)
    {
        guard let title = sender.currentTitle else {return}
        CitiesButton.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                
                button.isHidden = !button.isHidden
                
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
    
    
    enum citys: String
    {
        case telAviv = "Tel-Aviv"
        case jerusalem = "Jerusalem"
    }
    
    
    
    @IBAction func cityTapped(_ sender: UIButton)
    
    {
        guard let title = sender.currentTitle,
            let citiesList = citys(rawValue: title)  else {
            return
        }

        switch citiesList{
        case .telAviv:


            guard sessionCity.currentTitle != "Tel-Aviv" else {return}
            CitiesButton.forEach { (button) in
                UIView.animate(withDuration: 0.3, animations: {

                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                })
            }
            sessionCity.setTitle(title, for: .normal)

        case.jerusalem:


            guard sessionCity.currentTitle != "Jerusalem" else {return}
            CitiesButton.forEach { (button) in
                UIView.animate(withDuration: 0.3, animations: {

                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                })
            }
              sessionCity.setTitle(title, for: .normal)

        default:

            guard sender.currentTitle != nil else {return}
            CitiesButton.forEach { (button) in
                UIView.animate(withDuration: 0.3, animations: {

                    button.isHidden = !button.isHidden

                    self.view.layoutIfNeeded()
                })
        }

    }
    }

}

extension UIStackView
{
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}
