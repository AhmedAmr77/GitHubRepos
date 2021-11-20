//
//  CellPresenter.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 20/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class CellPresenter: RepoCellPresenterProtocol {
    
    weak var delegate: RepoCellProtocol?
    var networkManager: RepoCellNetworkManagerProtocol?

    let imagesCache = NSCache<AnyObject, AnyObject>()
    
    init(delegate: RepoCellProtocol) {
        self.delegate = delegate
        networkManager = RepoCellNetworkManager()
    }
    
    func getImage(url: String) {
        if let image = imagesCache.object(forKey: url as AnyObject) as? UIImage {
            print("getImage cache")
            self.delegate?.showImage(image: image)
        } else {
            print("getImage call")
            networkManager?.getOwnerAvatar(url: url, completion: { (data, err) in
                if let data = data {
                    if let image = UIImage(data: data){
                        self.imagesCache.setObject(image, forKey: url as AnyObject)
                    }
                    self.delegate?.showImage(image: UIImage(data: data) ?? UIImage(named: Constants.placeholderImage) ?? UIImage())
                }
            })
        }
    }
}
