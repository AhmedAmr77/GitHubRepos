//
//  Owner.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 19/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    let login: String //ownerName
    let avatar_url: String
}
