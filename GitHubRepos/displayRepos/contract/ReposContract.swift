//
//  ReposContract.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol ReposViewProtocol: BaseViewProtocol {
    func renderHomeWithRepos(repos: [Repo])
}

protocol ReposPresenterProtocol {
    func getRepos()
    func onSuccess(repos: [Repo])
    func onFail(errorMessage: String)
}

protocol ReposManagerProtocol {
    func getRepos(reposPresenterProtocol: ReposPresenterProtocol)
}

