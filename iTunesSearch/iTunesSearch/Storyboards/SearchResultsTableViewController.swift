//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Akmal Nurmatov on 5/4/20.
//  Copyright © 2020 Akmal Nurmatov. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        
        let searchResult = searchResultController.searchResults.results[indexPath.row]
        cell.detailTextLabel?.text = searchResult.creator
        cell.textLabel?.text = searchResult.title
        
        return cell
    }

    
}


extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        var resultType: ResultType!
        
        switch segmentedController.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
       
        default:
            resultType = .none
        }
        
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
