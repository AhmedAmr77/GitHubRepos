//
//  RepoDetailsViewController.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 20/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descreptionLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    var repoDetails: RepoDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = repoDetails?.name
        
        repoNameLabel.text = repoDetails?.name
        descreptionLabel.text = repoDetails?.description
        creationDateLabel.text = String(repoDetails?.created_at.prefix(10) ?? "2017-02-17")
        ownerNameLabel.text = repoDetails?.owner.login
    }

}
