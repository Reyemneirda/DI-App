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
    
    
    @IBOutlet var tapTheImage: UITapGestureRecognizer!
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
        picker.allowsEditing = true
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func getPhotoFromLibrary(_ sender: Any?) {
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
       
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let selectedImage = info [UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.profilePic.image = selectedImage
        let newImage = scaleDown(image: selectedImage, withSize: CGSize(width: 150, height: 150))
        uploadPic(newImage)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func scaleDown(image: UIImage, withSize: CGSize) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(withSize, false, scale)
        image.draw(in: CGRect(x: 0, y: 0, width: withSize.width, height: withSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func tapHere(_ sender: Any) {
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
        
        tapTheImage.delegate = self
        self.profilePic.isUserInteractionEnabled = true
        self.profilePic.addGestureRecognizer(tapTheImage)
        displayProfile()
//        defaultImage()
        // Do any additional setup after loading the view.
    }
    
    
    func displayProfile()
    {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("students").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject]
            {
                let user = User(dict: dict)
                
                self.fullNameTxt.text = user.name
                self.emailTxt.text = user.email
                self.phoneNumberTxt.text = user.phone
                self.sessionTxt.text = user.session
                self.linkedinTxt.text = user.linkedIn
                if let profileImageUrl = user.profilePic {
                    let url = URL(string: profileImageUrl)
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil {
                            print(error)
                        }
                        DispatchQueue.main.async {
                            self.profilePic.image = UIImage(data: data!)

                        }
                        
                    }).resume()
                }
//                
//                if let imageUrl = dict["profilePic"] as? String {
//                    self.downloadImage(url: URL(fileURLWithPath: imageUrl))
//                }
                
            }
        }, withCancel: nil)
        
    }
    
    
    func uploadPic(_ image: UIImage)
    {
        let imageName = NSUUID().uuidString
        let storage = Storage.storage().reference(forURL: "gs://di-app-14896.appspot.com/").child("ProfilePics").child("\(imageName)")
        DispatchQueue.main.async {
        if let uploadImage = UIImagePNGRepresentation(image) {
            storage.putData(uploadImage, metadata: nil, completion: { (metadata, error) in
                if error != nil
                {
                    print(error as Any)
                    return
                    
                }

                let profileURL = metadata?.downloadURL()
                if let profileImage = metadata?.downloadURL()?.absoluteString {
                    let uid = Auth.auth().currentUser?.uid
                    print(uid)
                    let ref = Database.database().reference()
                    let key = ref.child("students").child(uid!)
                    print(key)

                    let profilUpdate = ["profilePic": profileImage]

                    key.updateChildValues(profilUpdate)

                    
                    self.downloadImage(url: profileURL!)
                    
                }
                
            })
        }
            
        
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.profilePic.image = UIImage(data: data)
            }
        }
    }
    
//    func defaultImage() {
//        let uid = Auth.auth().currentUser?.uid
//        let ref = Database.database().reference()
//        
//        ref.child("students").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dictionnary = snapshot.value as? [String:String] {
//                if let imageUrl = dictionnary["profilePic"]{
//                    self.downloadImage(url: URL(fileURLWithPath: imageUrl))
//                }
//            }
//        })
//    }
    
}