//
//  ReposPresenter.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class ReposPresenter: ReposPresenterProtocol {
    
    weak var delegate: ReposViewProtocol?
    var networkManager: ReposNetworkManagerProtocol?
    
    var reposDetailsArray = [RepoDetails]()
    
    init(delegate: ReposViewProtocol) {
        self.delegate = delegate
        networkManager = ReposNetworkManager()
    }
    
    func getRepos() {
        delegate?.showLoading()
        networkManager?.getReposData(url: "https://api.github.com/repositories", completion: { (repos, err) in
            if let err = err {
                self.onFail(errorMessage: err.localizedDescription)
            } else {
                if let repos = repos {
                    for repo in repos {
                        self.networkManager?.getReposDetailsData(url: repo.url, completion: { (repoDetails, err) in
                            if let repoDetails = repoDetails {
                                self.reposDetailsArray.append(repoDetails)
                            }
                        })
                    }
                    self.onSuccess(repos: self.reposDetailsArray)
                }
            }
        })
    }
    
    func onSuccess(repos: [RepoDetails]) {
        delegate?.hideLoading()
        delegate?.renderHomeWithRepos(repos: repos)
    }
    
    func onFail(errorMessage: String) {
        delegate?.hideLoading()
        delegate?.showErrorMessage(errorMessage: errorMessage)
    }
    
    func onItemClick(row: Int) {
        delegate?.performActionWhenItemClick(row: row)
    }
}
