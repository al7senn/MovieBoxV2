//
//  HomeViewController.swift
//  MovieBox
//
//  Created by Hoi Pham Ngoc on 3/12/16.
//  Copyright © 2016 John Pham. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTopBar: UISearchBar!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var movies : [NSDictionary]?
    var endpoint: String!
    var isFirst: Bool = true
    var searchActive: Bool = false
    var filtered : [NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchTopBar.delegate = self
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetchMovies:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Get Movies Data from API
        fetchMovies(refreshControl)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered!.count
        } else {
        return movies?.count ?? 0
            }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {        
        let cell =  tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie : NSDictionary
        if searchActive {
            movie = filtered![indexPath.row]
        }else{
            movie = movies![indexPath.row]
        }
        
        
        let baseImageUrl = "http://image.tmdb.org/t/p/w500"
        let movieTitle = movie["title"] as! String
        let movieImageUrl = movie["backdrop_path"] as! String
        let moviePosterUrl = movie["poster_path"] as! String
        let movieReleaseDate = movie["release_date"] as! String
        let fullMovieImageUrl = NSURL(string: baseImageUrl + movieImageUrl)
        let fullMoviePosterUrl = NSURL(string: baseImageUrl + moviePosterUrl)
        
        
        cell.movieTitle.text = movieTitle
        cell.movieReleaseDate.text = movieReleaseDate
        cell.movieImage.setImageWithURL(fullMovieImageUrl!)
        cell.moivePosterBk.setImageWithURL(fullMoviePosterUrl!)
        
        return cell
    }
    
    
    func fetchMovies(refreshControl: UIRefreshControl) {
        
        
        
        // Load data from API
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        if isFirst {
                // Display HUD right before the request is made
                MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            isFirst  = false
        }

        
        let task = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData (
                        data, options:[]) as? NSDictionary {
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.tableView.reloadData()
                            refreshControl.endRefreshing()
                    }
                } else {
                    refreshControl.endRefreshing()
                }
                
                
        });
        task.resume()
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = movies?.filter({ (text) -> Bool in
            let tmp: NSString = text["title"] as! String
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered!.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    

    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movieData = movie
    }
     
    
}
