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
    var networkManager: ReposManagerProtocol?
    
    init(delegate: ReposViewProtocol) {
        self.delegate = delegate
//        networkManager =
    }
    
    func getRepos() {
        delegate?.showLoading()
//        networkManager?.getRepos(reposPresenterProtocol: self)
        
        // /*
        onSuccess(repos: [RepoDetails(name: "shopme", owner: Owner(login: "amr", avatar_url: "aa", avatar_data: Data()), created_at: "12-5-2021"), RepoDetails(name: "sportify", owner: Owner(login: "ahmd", avatar_url: "aa", avatar_data: Data()), created_at: "16-16-2021")])
        // */
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
