//
//  BaseContarct.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol BaseViewProtocol {
    func showLoading()
    func hideLoading()
    func showErrorMessage(errorMessage : String)
}
