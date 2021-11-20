//
//  RepoCellNetworkManager.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 20/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class RepoCellNetworkManager: RepoCellNetworkManagerProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getOwnerAvatar(url: String, completion: @escaping (Data?, Error?) -> Void) {
        if let url = URL(string: url) {
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(data, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, NSError(domain: "Status code", code: (response as? HTTPURLResponse)?.statusCode ?? 00, userInfo: nil) )
                    }
                }
            }
            dataTask?.resume()
        }
    }
}
