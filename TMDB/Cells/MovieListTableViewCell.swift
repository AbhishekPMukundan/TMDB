//
//  MovieListTableViewCell.swift
//  TMDB
//
//  Created by Abhishek on 29/10/20.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    //MARK: - Properties
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var votingAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
}
