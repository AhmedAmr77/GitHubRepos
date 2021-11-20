//
//  RepoCellContract.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 20/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

protocol RepoCellProtocol: class {
    func updateUI(repo: RepoDetails)
    func loadImage()
    func showImage(image: UIImage)
}

protocol RepoCellPresenterProtocol {
    func getImage(url: String)
}

protocol RepoCellNetworkManagerProtocol {
    func getOwnerAvatar(url: String, completion: @escaping (Data?, Error?) -> Void)
}
