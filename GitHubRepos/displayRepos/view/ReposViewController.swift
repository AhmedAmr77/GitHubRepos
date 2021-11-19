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
    
    var reposArray = [RepoDetails(name: "shopme", owner: Owner(login: "amr", avatar_url: "aa", avatar_data: Data()), created_at: "12-5-2021"), RepoDetails(name: "sportify", owner: Owner(login: "ahmd", avatar_url: "aa", avatar_data: Data()), created_at: "16-16-2021") ] //[RepoDetails]()
    var filteredData = [RepoDetails]()
    var isFiltering: Bool {
        return searchController.isActive && searchController.searchBar.text?.count ?? 2 > 1
    }
    
    var activityIndicator: UIActivityIndicatorView!
    
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
        
        //get repos
//        ReposPresenter(reposViewProtocol: self).getRepos()
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
        
        let repo: RepoDetails
        if isFiltering {
            repo = filteredData[indexPath.row]
        } else {
            repo = reposArray[indexPath.row]
        }

        cell.repoNameLabel.text = repo.name
        cell.ownerNameLabel.text = repo.owner.login
        cell.creationDateLabel.text = repo.created_at
        cell.avatarImageView.image = UIImage(data: repo.owner.avatar_data)
        
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
                filteredData = reposArray.filter({ (repo) -> Bool in
                    return repo.name.lowercased().contains(searchText.lowercased())
                })
            }
            tableView.reloadData()
        }
    }
}

extension ReposViewController: ReposViewProtocol {
    func renderHomeWithRepos(repos: [RepoDetails]) {
        reposArray = repos
        tableView.reloadData()
    }
    
    func showLoading() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        self.activityIndicator.center = self.tableView.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showErrorMessage(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in /*any action needed*/}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
