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
    
    
    var moviesData : [NSDictionary]?
    var refreshControl: UIRefreshControl!
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
