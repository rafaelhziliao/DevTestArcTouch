//
//  MovieListCell.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 03/08/2018.
//  Copyright © 2018 Rafael Zilião. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListCell: UITableViewCell {
    static let identifier = "MovieListCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageview: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.Colors.primaryBackgroundColor
        titleView.backgroundColor = UIColor.Colors.primaryBackgroundColor
        self.titleLabel.textColor = UIColor.Colors.lightColor
        self.releaseDateLabel.textColor = UIColor.Colors.grayColor
        self.overviewLabel.textColor = UIColor.Colors.grayColor
        
        
        self.rateLabel.layer.cornerRadius = 2
        self.rateLabel.clipsToBounds = true
        
        accessoryType = UITableViewCellAccessoryType.none
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.Colors.highlightBackgroundColor
        selectedBackgroundView = backgroundView
    }
    
    func render(movie: Movie) {
        self.titleLabel.text = movie.title
        let date = movie.releaseDate
        let year = date.index(date.startIndex, offsetBy: 3)
        self.releaseDateLabel.text = String(date[...year])
        
        self.rateLabel.text = String(movie.voteAverage)
        self.rateLabel.backgroundColor = movie.voteAverage > 5 ? UIColor.Colors.highRatingBackgroundColor : UIColor.Colors.lowRatingBackgroundColor
        self.rateLabel.textColor = movie.voteAverage > 5 ? UIColor.black : UIColor.white
        self.overviewLabel.text = movie.overview
        
        self.posterImageview.af_setImage(withURL: URL(string: movie.posterPath(size: .small))!, imageTransition: .crossDissolve(0.2))
    }

}
