//
//  MovieSummaryTableViewCell.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit

class MovieSummaryTableViewCell: UITableViewCell {
    public static let identifier: String = "MovieSummaryTableViewCell"
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     }
    
    public static func getNib() -> UINib {
        let nib = UINib(nibName: identifier, bundle: nil)
        return nib
    }
    
    public func setupCell(movieSummary: MovieSummary) {
        setCellImage(movieSummary)
        title.text = movieSummary.title
        releaseDate.text = movieSummary.releaseDate.formatted(date: .long, time: .omitted)
    }
    
    fileprivate func setCellImage(_ movieSummary: MovieSummary) {
        self.movieImage.image = UIImage(systemName:"film")
        
        if let url = URL(string: movieSummary.posterUrl) {
            UIImage.loadFrom(url: url) { image in
                if let image = image {
                    self.movieImage.image = image
                }
            }
        }
    }
}
