//
//  ViewController.swift
//  FlickrPhotos
//
//  Created by Srinivas Gadda on 11/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var feedVM: FlickrFeedViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
        feedVM = FlickrFeedViewModel(apiClient: ApiClient())
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedVM?.numberOfFeedItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell {
            if let itemModel = feedVM?.feedItems?[indexPath.row] {
                cell.configureCell(item: itemModel)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhotoDetailsViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
            destination.item = feedVM?.feedItems?[selectedRow]
        }
    }
}

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    @MainActor
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty {
            Task {
                await feedVM?.fetchPhotos(searchTerm: searchText)
                tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
}
