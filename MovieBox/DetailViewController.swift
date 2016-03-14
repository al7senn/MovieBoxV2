//
//  DetailViewController.swift
//  MovieBox
//
//  Created by Johnny Pham on 3/14/16.
//  Copyright © 2016 John Pham. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieDetailPoster: UIImageView!
    @IBOutlet weak var movieDetailTitle: UILabel!
    @IBOutlet weak var movieDetailMeta: UILabel!
    @IBOutlet weak var movieDetailBG: UIImageView!
    
    @IBOutlet weak var movieDetailOverview: UITextView!
    
    var movieData : NSDictionary!
    var refreshControl: UIRefreshControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let movieTitle = movieData["title"] as! String
        let movieReleaseDate = movieData["release_date"]
        let movieMeta = movieData["release_date"] as! String
        let movieOverview = movieData["overview"] as! String
        let baseImageUrl = "http://image.tmdb.org/t/p/w500"
        
        
        let movieImageUrl = movieData["backdrop_path"] as! String
        let moviePosterUrl = movieData["poster_path"] as! String
        
        let fullMovieImageUrl = NSURL(string: baseImageUrl + movieImageUrl)
        let fullMoviePosterUrl = NSURL(string: baseImageUrl + moviePosterUrl)
        
        movieDetailTitle.text = movieTitle
        movieDetailMeta.text = movieMeta
        movieDetailOverview.text = movieOverview
        movieDetailBG.setImageWithURL(fullMovieImageUrl!)
        movieDetailPoster.setImageWithURL(fullMoviePosterUrl!)

        
        
        print(movieData)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPathForCell(cell)
    let movie = movies![indexPath]
    
    print("prepare for segue called")
    // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
