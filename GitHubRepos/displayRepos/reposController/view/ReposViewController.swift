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
    
    var reposArray = [RepoDetails]()
    var filteredData = [RepoDetails]()
    var isFiltering: Bool {
        return searchController.isActive && searchController.searchBar.text?.count ?? 2 > 1
    }
    
    var activityIndicator: UIActivityIndicatorView!
    var presenter: ReposPresenterProtocol?
    
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
        presenter = ReposPresenter(delegate: self)
        presenter?.getRepos()
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
        cell.updateUI(repo: repo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 10	
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onItemClick(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? ReposTableViewCell
        cell?.loadImage()
        if indexPath.row + 1 == reposArray.count {
            presenter?.getRepoDetails()
        }
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
        reposArray += repos
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
        let okAction  = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func performActionWhenItemClick(row: Int) {
        print("repo clicked")
        //if filtered or not
    }
}
