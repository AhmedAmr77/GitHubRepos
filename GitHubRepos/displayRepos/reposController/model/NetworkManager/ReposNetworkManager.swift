//
//  ReposNetworkManager.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class ReposNetworkManager: ReposNetworkManagerProtocol {
    
    let networkService = NetworkService()
        
    func getReposData(url: String, completion: @escaping ([Repo]?, Error?) -> Void) {
        networkService.getData(url: url) { (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    do {
                        let reposArray = try JSONDecoder().decode([Repo].self, from: data)
                        DispatchQueue.main.async {
                            completion(reposArray, nil)
                        }
                    } catch let parseError {
                        DispatchQueue.main.async {
                            completion(nil, parseError)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, NSError(domain: "Empty Response", code: 01, userInfo: nil))
                    }
                }
                
            case .failure(let err):
                DispatchQueue.main.async {
                    completion(nil, err)
                }
            }
        }
    }
    
    func getReposDetailsData(url: String, completion: @escaping (RepoDetails?, Error?) -> Void) {
        networkService.getData(url: url) { (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    do {
                        let repoDetails = try JSONDecoder().decode(RepoDetails.self, from: data)
                        DispatchQueue.main.async {
                            completion(repoDetails, nil)
                        }
                    } catch let parseError {
                        DispatchQueue.main.async {
                            completion(nil, parseError)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, NSError(domain: "Empty Response", code: 01, userInfo: nil))
                    }
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    completion(nil, err)
                }
            }
        }
    }
}
