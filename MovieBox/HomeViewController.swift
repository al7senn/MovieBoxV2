//
//  HomeViewController.swift
//  MovieBox
//
//  Created by Hoi Pham Ngoc on 3/12/16.
//  Copyright © 2016 John Pham. All rights reserved.
//

import UIKit
import AFNetworking

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    
    var movies : [NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchMovies()
        
        

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {        
        let cell =  tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let baseImageUrl = "http://image.tmdb.org/t/p/w500"
        
        let movie = movies![indexPath.row] as NSDictionary 
        let movieTitle = movie["title"] as! String
        
        let movieImageUrl = movie["backdrop_path"] as! String
        let moviePosterUrl = movie["poster_path"] as! String
        let movieReleaseDate = movie["release_date"] as! String
        let fullMovieImageUrl = NSURL(string: baseImageUrl + movieImageUrl)
        let fullMoviePosterUrl = NSURL(string: baseImageUrl + moviePosterUrl)
        
        
        cell.movieTitle.text = movieTitle
        cell.movieReleaseDate.text = movieReleaseDate
        cell.movieImage.setImageWithURL(fullMovieImageUrl!)
        cell.moviePoster.setImageWithURL(fullMoviePosterUrl!)
        
        return cell
    }
    func fetchMovies() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData (
                        data, options:[]) as? NSDictionary {
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        
        
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movieData = movie
        
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier("newSegue", sender: self)
        print("select cell")
    }
    
    
   

    
    
    
    
}
