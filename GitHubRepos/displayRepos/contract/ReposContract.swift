//
//  ReposContract.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol ReposViewProtocol: class, BaseViewProtocol {
    func renderHomeWithRepos(repos: [RepoDetails])
    func performActionWhenItemClick(row: Int)
}

protocol ReposPresenterProtocol {
    func getRepos()
    func onSuccess(repos: [RepoDetails])
    func onFail(errorMessage: String)
    func onItemClick(row: Int)
}

protocol ReposNetworkManagerProtocol {
    func getReposData(url: String, completion: @escaping ([Repo]?, Error?) -> Void)
    func getReposDetailsData(url: String, completion: @escaping (RepoDetails?, Error?) -> Void) 
}

