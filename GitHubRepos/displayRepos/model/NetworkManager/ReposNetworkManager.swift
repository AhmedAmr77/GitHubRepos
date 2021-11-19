//
//  ReposNetworkManager.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class ReposNetworkManager: ReposNetworkManagerProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    
    var reposArray = [Repo]()
    
    var repoDetailsArray: [RepoDetails] = []
    
    func getReposData(url: String, completion: @escaping ([Repo]?, Error?) -> Void) {
        
        if let url = URL(string: url) {
            
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                
                if let error = error {
                    completion(nil, error)
                    return
                }
                if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    do {
                        self?.reposArray = try JSONDecoder().decode([Repo].self, from: data)
                        print(self?.reposArray)
                        DispatchQueue.main.async {
                            completion(self?.reposArray, nil)
                        }
                    } catch let parseError as NSError {
                        print("1",parseError)
                        DispatchQueue.main.async {
                            completion(nil, parseError)
                        }
                        return
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, NSError(domain: "status code error", code: 10, userInfo: nil) )
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
    
    func getReposDetailsData(url: String, completion: @escaping (RepoDetails?, Error?) -> Void) {
        
        if let url = URL(string: url) {
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    completion(nil, error)
                    return
                }
                if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    do {
                        let repoDetails = try JSONDecoder().decode(RepoDetails.self, from: data)
                        DispatchQueue.main.async {
                            completion(repoDetails, nil)
                        }
                    } catch let parseError as NSError {
                        print("1",parseError)
                        DispatchQueue.main.async {
                            completion(nil, parseError)
                        }
                        return
                    }
                } else {
                    completion(nil, NSError(domain: "status code error", code: 10, userInfo: nil) )
                }
            }
            
            dataTask?.resume()
        }
    }
    
    
    
//    func getRepos(reposPresenterProtocol: ReposPresenterProtocol) {
//        manager.getReposData(url: "https://api.github.com/repositories") { (reposArr, err) in
//            if let err = err {
//                reposPresenterProtocol.onFail(errorMessage: err.localizedDescription)
//            } else {
////                reposPresenterProtocol.onSuccess(repos: reposArr ?? [Repo]())
//                for repo in
//                manager.getReposDetailsData(url: <#T##String#>, isLast: <#T##Bool#>, completion: <#T##(RepoDetails?, Error?) -> Void#>)
//            }
//        }
//    }
}
