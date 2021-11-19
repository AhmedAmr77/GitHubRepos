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
    
    
    var searchController: UISearchController!
    
    var reposArray = ["1", "356", "3", "2035698", "7705356"]
    var filteredData = [String]()
    var isFiltering: Bool {
        return searchController.isActive && searchController.searchBar.text?.count ?? 2 > 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //register cell
        let nibCell = UINib(nibName: Constants.reposCellId, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: Constants.reposCellId)
        
        //search controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Repos"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
    }


}

extension ReposViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredData.count
        }
        return reposArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reposCellId, for: indexPath) as! ReposTableViewCell
        
        let repo: String
        if isFiltering {
            repo = filteredData[indexPath.row]
        } else {
          repo = reposArray[indexPath.row]
        }

        cell.repoNameLabel.text = repo
        cell.ownerNameLabel.text = repo
        cell.creationDateLabel.text = repo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 10	
    }
}

extension ReposViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText.count > 1 {
                filteredData = reposArray.filter({(dataString: String) -> Bool in
                    return dataString.lowercased().contains(searchText.lowercased())
                })
            }
            tableView.reloadData()
        }
    }
}
