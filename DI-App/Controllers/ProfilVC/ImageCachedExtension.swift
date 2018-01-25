//
//  ImageCachedExtension.swift
//  DI-App
//
//  Created by Adrien Meyer on 24/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit

let imageCached = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageCachedwithURLString(urlString: String){
        
        if let cachedImage = imageCached.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
            }
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCached.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            
                
            }
            
        }).resume()
    }
}
