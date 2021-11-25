//
//  RepoCellNetworkManager.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 20/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class RepoCellNetworkManager: RepoCellNetworkManagerProtocol {

    let networkService = NetworkService()

    func getOwnerAvatar(url: String, completion: @escaping (Data?, Error?) -> Void) {
        networkService.getData(url: url) { (resurl) in
            switch resurl {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    completion(nil, err)
                }
            }
        }
    }
}
