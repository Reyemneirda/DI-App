//
//  OnsenfoutViewController.swift
//  DI-App
//
//  Created by Adrien Meyer on 21/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class OnsenfoutViewController: BaseViewController {

    @IBOutlet weak var hello: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsin()
        // Do any additional setup after loading the view.
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
                    self.hello.text = dictionnary["name"] as! String?
                    
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
