//
//  ViewController.swift
//  Collection View - Git_Hub
//
//  Created by Mac on 27/03/2563 BE.
//  Copyright © 2563 DND. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController {
    var photoID : [[String:Any]] = [[String:Any]]()
    var array: [Int] = []
    // MARK :- Variables
    var imageArray = ["image1","image2","image3","image4","image5","image6","image7"]
    //MARK :- Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        let key = "15810784-31acc612296e0df4b99e752e9"
        let link = "https://pixabay.com/api/?key=\(key)&q=yellow+flowers&image_type=photo&pretty=true"
        Alamofire.request(link).responseJSON{
            (respones) in
        if let responseValue = respones.result.value as! [String: Any]? {
         if let responseHits = responseValue["hits"] as! [[String:Any]]?{
             //(responseHits)
             if responseHits.count > 0{
             for i in 0..<responseHits.count
              {
               // print(responseHits[i]["previewURL"])
                  let imageURL = responseHits[i]
              if let url = imageURL["previewURL"] as? String{
                print(url)
                self.imageArray.append(url)
                }
            }
        }
    }
 }
}
            
              print(imageArray)
        print("App Launched")
        if let layout = collectionView.collectionViewLayout as? PinterestLayout{
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
}
}

extension ViewController: PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: imageArray[indexPath.item])
        let height = image!.size.height
        return height
    }
    
    
}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let image = UIImage(named: imageArray[indexPath.item])
        cell.imageView.image = image!
        return cell
    }
    
    
}

