//
//  NetworkService.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 25/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class NetworkService {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: url) {
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    completion(.success(data))
                } else {
                    completion(.failure(NSError(domain: "Status code", code: (response as? HTTPURLResponse)?.statusCode ?? 00, userInfo: nil)))
                }
            }
            dataTask?.resume()
        } else {
            completion(.failure(NSError(domain: "Wrong URL", code: 00, userInfo: nil)))
        }
    }
}
