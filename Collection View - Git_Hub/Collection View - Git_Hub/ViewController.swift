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
    let viewModel = ViewModel(client: UnspalshClient())
    
    //MARK :- Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        
        
     
        /* Alamofire.request("https://api.unsplash.com/photos/",
                           method: .get,
                           parameters: ["YttK1qKKQ0j7DEuQixvyxuZJSY1iVTPRIAMXLlzznPk": ".latest"])
         .validate()
         .responseJSON { response in
           guard response.result.isSuccess else {
            // print("Error while fetching remote rooms:\(String(describing: response.result.error)" )
            // completion(nil)
             return
           }
            //print(value)
           guard let value = response.result.value as? [UIImage: Any],
             let rows = value["rows"] as? [[UIImage: Any]] else {

               print("Malformed data received from fetchAllRooms service")
              // completion(nil)
               return
           }

                    }
         
        */
        
        super.viewDidLoad()
        
        
     /*   request(.GET, method: HTTPMethod(rawValue: "https://api.unsplash.com/photos/")!, parameters: ["YttK1qKKQ0j7DEuQixvyxuZJSY1iVTPRIAMXLlzznPk": ".latest"])
        .responseSwiftyJSON { (request, response, json, error) in
                    println(json)
                    println(error)
                  }
        
       */
        
        Alamofire.request("https://pixabay.com/api/15810784-31acc612296e0df4b99e752e9",method: .get).responseString{(respons) in
            if respons.result.isSuccess{
                print("Success With Samur")
                print(respons.result.value!)
            }else{
                print("Failed")
            }
        }
        
        print("App Launched")
        if let layout = collectionView.collectionViewLayout as? PinterestLayout{
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        viewModel.showLoading = {
            if self.viewModel.isLoading {
                self.activityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            }else{
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }
        viewModel.showError = { error in
            print(error)
        }
        viewModel.reloadData = {
            self.collectionView.reloadData()
        }
        viewModel.fetchPhotos()
    }


}

extension ViewController: PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = viewModel.cellViewModels[indexPath.item].image
        let height = image.size.height
        return height
    }
    
    
}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let image = viewModel.cellViewModels[indexPath.row].image
        cell.imageView.image = image
        //cell.imageView.frame.size.width = cell.frame.size.width
        return cell
    }
    
    
}
extension ViewController{
    //ALOMAFIRE
   
}
