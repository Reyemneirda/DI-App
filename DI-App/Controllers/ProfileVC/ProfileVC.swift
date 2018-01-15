//
//  ProfileVC.swift
//  DI-App
//
//  Created by Gabriel Drai on 20/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage



class ProfileVC: BaseViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let storageRef = Storage.storage().reference(forURL: "gs://di-app-14896.appspot.com/")
    

    @IBOutlet weak var fullNameTxt: UITextView!
    @IBOutlet weak var phoneNumberTxt: UITextView!
    @IBOutlet weak var emailTxt: UITextView!
    @IBOutlet weak var linkedinTxt: UITextView!
    @IBOutlet weak var sessionTxt: UITextView!
    

    @IBOutlet weak var profilePic: UIImageView!
    
    
    
    @IBOutlet weak var actionSheetButton: UIButton!
    
    @IBAction func takePhoto(_ sender: Any?) {
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func getPhotoFromLibrary(_ sender: Any?) {
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self 
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let selectedImage = info [UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.profilePic.image = selectedImage
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let uid = Auth.auth().currentUser?.uid
        let key = Database.database().reference().child("students").childByAutoId().key
        if let uploadData = UIImagePNGRepresentation(self.profilePic.image!)
        {
            DispatchQueue.main.async {

                self.storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil
                {
                    print(error as Any)
                    
                    return
                }
                let imageURL = metadata?.downloadURL()
                let childUpdate = ["/profilPic/\(key)":imageURL]
                 Database.database().reference().updateChildValues(childUpdate)

                print(metadata)



            })
            }
        }

        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func getActionSheet(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Pick an option", preferredStyle: .actionSheet)
        
        let cameraOpt = UIAlertAction(title: "Camera", style: .default, handler: {
            (action) in
            
            self.takePhoto(nil)
          

        })
        
        actionSheet.addAction(cameraOpt)
        
        let libraryOpt = UIAlertAction(title: "From Library", style: .default, handler: {
            (action) in
            
            self.getPhotoFromLibrary(nil)
        })
        
        actionSheet.addAction(libraryOpt)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2
        self.actionSheetButton.layer.cornerRadius = self.actionSheetButton.frame.size.width / 2
        
        displayProfile()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func displayProfile()
    {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("students").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
          if let dict = snapshot.value as? [String:AnyObject]
            {
                self.fullNameTxt.text = dict["name"] as! String
                self.emailTxt.text = dict["email"] as! String
                self.phoneNumberTxt.text = dict["phone"] as! String
                self.sessionTxt.text = dict["session"] as! String
                self.linkedinTxt.text = dict["linkedIn"] as! String
                
            }
        }, withCancel: nil)
            
    }
    
 
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
