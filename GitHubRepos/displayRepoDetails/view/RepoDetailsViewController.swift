//
//  RepoDetailsViewController.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 20/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    var repoDetails: RepoDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = repoDetails?.name
    }

}
