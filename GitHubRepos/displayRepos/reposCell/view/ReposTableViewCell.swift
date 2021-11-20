//
//  ReposTableViewCell.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class ReposTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    var presenter: RepoCellPresenterProtocol?
    var repo: RepoDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        presenter = CellPresenter(delegate: self)
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
extension ReposTableViewCell: RepoCellProtocol {
    func updateUI(repo: RepoDetails) {
        self.repo = repo
        repoNameLabel.text = repo.name
        ownerNameLabel.text = repo.owner.login
        creationDateLabel.text = String(repo.created_at.prefix(10))
    }
    
    func loadImage() {
        if let repo = repo {
            presenter?.getImage(url: repo.owner.avatar_url)
        }
    }
    
    func showImage(image: UIImage) {
        avatarImageView.image = image
    }
}
