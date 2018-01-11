//
//  ProfileVC.swift
//  DI-App
//
//  Created by Gabriel Drai on 20/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet var tapImage: UITapGestureRecognizer!
    
    @IBAction func takePhoto(_ sender: Any) {
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func getPhotoFromLibrary(_ sender: Any) {
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let selectedImage = info [UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.profilePic.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2
        profilePic.isUserInteractionEnabled = true
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        singleTap.numberOfTapsRequired = 1;
        profilePic.addGestureRecognizer(singleTap)
        
        // Do any additional setup after loading the view.
    }

    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("tap")
        let alertView = UIAlertController(title: "Profile Picture", message: "Pick an Option", preferredStyle: .actionSheet)
        
        let cameraOpt = UIAlertAction(title: "From Camera", style: .default, handler: nil)
        
        alertView.addAction(cameraOpt)
        
        let libraryOpt = UIAlertAction(title: "From the Library", style: .default, handler: nil)
        
        alertView.addAction(libraryOpt)
   
        self.present(alertView, animated: true, completion: nil)
        
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
