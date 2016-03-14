//
//  MovieCell.swift
//  MovieBox
//
//  Created by Hoi Pham Ngoc on 3/13/16.
//  Copyright © 2016 John Pham. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var moivePosterBk: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
