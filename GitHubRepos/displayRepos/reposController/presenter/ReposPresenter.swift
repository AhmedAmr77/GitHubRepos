//
//  ReposPresenter.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class ReposPresenter: ReposPresenterProtocol {
    
    weak var delegate: ReposViewProtocol?
    var networkManager: ReposNetworkManagerProtocol?
    
    var reposArray = [Repo]()
    var reposDetailsArray = [RepoDetails]()
    var reposDetailsCounter = 0
    private var isFetchInProgress = false
    
    init(delegate: ReposViewProtocol) {
        self.delegate = delegate
        networkManager = ReposNetworkManager()
    }
    
    func getRepos() {
        delegate?.showLoading()
        networkManager?.getReposData(url: Constants.reposURL, completion: { (repos, err) in
            if let err = err {
                self.onFail(errorMessage: err.localizedDescription)
            } else {
                if let repos = repos {
                    self.delegate?.hideLoading()
                    self.reposArray = repos
                    self.getRepoDetails()
                }
            }
        })
    }
    
    func getRepoDetails() {
        if reposDetailsCounter < reposArray.count && !isFetchInProgress {
            delegate?.showLoading()
            isFetchInProgress = true
            
            let downloadGroup = DispatchGroup()
            
            for repo in reposArray[reposDetailsCounter ..< min(reposDetailsCounter+20, self.reposArray.count)]{
                print("For counter=>", reposDetailsCounter)
                downloadGroup.enter()
                networkManager?.getReposDetailsData(url: repo.url, completion: { (repoDetails, err) in
                    if let repoDetails = repoDetails {
                        self.reposDetailsArray.append(repoDetails)
                        self.reposDetailsCounter += 1
                    }
                    downloadGroup.leave()
                })
            }
            
            downloadGroup.notify(queue: DispatchQueue.main) {
                print("downloadGroup notify")
                self.isFetchInProgress = false
                self.onSuccess(repos: self.reposDetailsArray)
                self.reposDetailsArray.removeAll()
            }
        }
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
