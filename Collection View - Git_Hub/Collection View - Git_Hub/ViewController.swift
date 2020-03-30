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

    // MARK :- Variables
    var imageArray = ["image1","image2","image3","image4","image5","image6","image7"]
    //MARK :- Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        print("App Launched")
        if let layout = collectionView.collectionViewLayout as? PinterestLayout{
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func parseData(JSONData : Data){
        do{
        let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options:.allowFragments) as! [[UIImage:AnyObject]]
        print(readableJSON.count)
        }catch{
            
        }

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
        cell.imageView.image = image as! UIImage
        return cell
    }
    
    
}

