//
//  ViewModel.swift
//  Collection View - Git_Hub
//
//  Created by Mac on 29/03/2563 BE.
//  Copyright © 2563 DND. All rights reserved.
//

import Foundation
import UIKit

struct CellViewModel {
    let image : UIImage
}

class ViewModel{
    private let client : APIClient
    private var photos : Photos = []{
        didSet{
            self.fetchPhotos()
        }
    }
    var  cellViewModels : [CellViewModel] = []
    
    var isLoading : Bool = false{
        didSet{
            showLoading?()
        }
    }
    
    var showLoading : (()-> Void)?
    var reloadData : (()-> Void)?
    var showError : ((Error)-> Void)?
    
    init(client: APIClient) {
        self.client = client
    }
    
    func fetchPhotos(){
        if let client = client as? UnspalshClient{
            self.isLoading = true
            let endPoint = UnspashEndPoint.photos(id: UnspalshClient.apiKey, order: .latest)
            client.fetch(with: endPoint){ (either) in
                switch either{
                case .success(let photos):
                    self.photos = photos
                case .error(let error):
                    self.showError?(error)
                }
                
            }
        }
    }
    
    
    private func fetchPhoto(){
        let group = DispatchGroup()
        
        
        self.photos.forEach{(photos) in
            DispatchQueue.global(qos: .background).async(group: group) {
                group.enter()
                guard let imageData = try? Data(contentsOf : photos.urls.small) else{
                    self.showError?(APIError.imageDownload)
                    return
                }
                guard let image = UIImage(data: imageData)else{
                    self.showError?(APIError.imageConvert)
                    return
                }
                self.cellViewModels.append(CellViewModel(image: image))
                print(image)
                group.leave()
            }
        }
        group.notify(queue: .main){
            self.isLoading = false
            self.reloadData?()
        }
    }
}
