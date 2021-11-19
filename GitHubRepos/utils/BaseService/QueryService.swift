////
////  QueryService.swift
////  GitHubRepos
////
////  Created by Ahmd Amr on 19/11/2021.
////  Copyright © 2021 ahmdamr. All rights reserved.
////
//
//import UIKit
//
//enum UrlType: String{
//    case repos
//    case repoDetails
//    case image
//}
//
//class QueryService {
//    
//    let defaultSession = URLSession(configuration: .default)
//    
//    var dataTask: URLSessionDataTask?
//    
//    var reposArray = [Repo]()
//    
//    var repoDetailsArray: [RepoDetails] = []
//    
//    func getReposData(url: String, completion: @escaping ([Repo]?, Error?) -> Void) {
//        
//        if let url = URL(string: url) {
//            
//            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
//                
//                if let error = error {
//                    completion(nil, error)
//                    return
//                }
//                if let data = data,
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 {
//                    
//                    do {
//                        self?.reposArray = try JSONDecoder().decode([Repo].self, from: data)
//                        print(self?.reposArray)
//                        DispatchQueue.main.async {
//                            completion(self?.reposArray, nil)
//                        }
//                    } catch let parseError as NSError {
//                        print("1",parseError)
//                        DispatchQueue.main.async {
//                            completion(nil, parseError)
//                        }
//                        return
//                    }
//                } else {
//                    completion(nil, NSError(domain: "status code error", code: 10, userInfo: nil) )
//                }
//            }
//            
//            dataTask?.resume()
//        }
//    }
//    
//    func getReposDetailsData(url: String, isLast: Bool, completion: @escaping (RepoDetails?, Error?) -> Void) {
//        
//        if let url = URL(string: url) {
//            
//            dataTask = defaultSession.dataTask(with: url) { data, response, error in
//                
//                if let error = error {
//                    completion(nil, error)
//                    return
//                }
//                if let data = data,
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 {
//                    
//                    do {
//                        let repoDetails = try JSONDecoder().decode(RepoDetails.self, from: data)
//                        DispatchQueue.main.async {
//                            completion(repoDetails, nil)
//                        }
//                    } catch let parseError as NSError {
//                        print("1",parseError)
//                        DispatchQueue.main.async {
//                            completion(nil, parseError)
//                        }
//                        return
//                    }
//                } else {
//                    completion(nil, NSError(domain: "status code error", code: 10, userInfo: nil) )
//                }
//            }
//            
//            dataTask?.resume()
//        }
//    }
//    
////    private func parsData(urlType:UrlType, _ data: Data, completion: @escaping ([Repo]?, [RepoDetails]?, Error?) -> Void) {
////        DispatchQueue.main.async {
////            switch urlType {
////            case .repos:
////
////            case .repoDetails:
////                do {
////                    let repoDetails = try JSONDecoder().decode(RepoDetails.self, from: data)
////                    self.repoDetailsArray.append(repoDetails)
////                    completion(nil, self.repoDetailsArray, nil)
////                    print(self.reposArray)
////                } catch let parseError as NSError {
////                    print("1",parseError)
////                    completion(nil, nil, parseError)
////                    return
////                }
////
////            case .image:
////                print("sasasa")
////                //            repoDetailsArray[0].owner.avatar_Image = UIImage(data: data) ?? UIImage(named: "placeholder") ?? UIImage()
////            }
////        }
////    }
//}
