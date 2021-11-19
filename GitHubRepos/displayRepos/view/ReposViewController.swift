//
//  ReposViewController.swift
//  GitHubRepos
//
//  Created by Ahmd Amr on 18/11/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var reposArray = ["1", "2", "3", "4", "5"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //register cell
        let nibCell = UINib(nibName: Constants.reposCellId, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: Constants.reposCellId)
    }


}

extension ReposViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reposCellId, for: indexPath) as! ReposTableViewCell
        
        cell.repoNameLabel.text = reposArray[indexPath.row]
        cell.ownerNameLabel.text = reposArray[indexPath.row]
        cell.creationDateLabel.text = reposArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 10	
    }
}

