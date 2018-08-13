//
//  MovieDetailCell.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 11/08/2018.
//  Copyright © 2018 Rafael Zilião. All rights reserved.
//

import Foundation
import AlamofireImage

class MovieDetailCell: UITableViewCell {
    static let identifier = "MovieDetailCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.Colors.primaryBackgroundColor
        self.titleLabel.textColor = UIColor.Colors.primaryColor
        self.runtimeLabel.textColor = UIColor.Colors.lightColor
        self.genresLabel.textColor = UIColor.Colors.grayColor
        self.tagLineLabel.textColor = UIColor.Colors.lightColor
        self.overviewTextLabel.textColor = UIColor.Colors.grayColor
        self.overviewLabel.textColor = UIColor.Colors.lightColor
        self.rateLabel.layer.cornerRadius = 2
        self.rateLabel.clipsToBounds = true
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewTextLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var effectView: UIView!
    @IBOutlet weak var detailBackDropImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
    }
    
    func render(movie: Movie) {
        let darkBlur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        
        blurView.autoresizesSubviews = true
        blurView.autoresizingMask = [UIViewAutoresizing.flexibleWidth,  UIViewAutoresizing.flexibleHeight]
        blurView.frame = self.detailBackDropImageView.bounds
        
        self.detailBackDropImageView.af_setImage(withURL: URL(string: movie.posterPath(size: .medium
        ))!, imageTransition: .crossDissolve(0.2))
        self.detailBackDropImageView.addSubview(blurView)
        
        self.posterImageView.af_setImage(withURL: URL(string: movie.posterPath(size: .small))!, imageTransition: .crossDissolve(0.2))
        self.titleLabel.text = movie.title
        self.tagLineLabel.text = movie.tagline
        self.rateLabel.text = String(movie.voteAverage!)
        self.rateLabel.backgroundColor = movie.voteAverage! > 5.0 ? UIColor.Colors.highRatingBackgroundColor : UIColor.Colors.lowRatingBackgroundColor
        self.rateLabel.textColor = movie.voteAverage! > 5.0 ? UIColor.black : UIColor.white
        self.runtimeLabel.text = movie.formatedRunTime
        self.genresLabel.text = movie.genres?.map{$0.name}.joined(separator: ", ")
        self.overviewTextLabel.text = movie.overview
    }
    
}
