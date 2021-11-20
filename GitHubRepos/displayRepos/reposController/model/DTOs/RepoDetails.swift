//
//  RepoDetails.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

struct RepoDetails: Decodable {
    let name: String
    var owner: Owner
    let created_at: String
    let description: String?
}
