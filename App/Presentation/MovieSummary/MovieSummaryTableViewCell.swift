//
//  MovieSummaryTableViewCell.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit

class MovieSummaryTableViewCell: UITableViewCell {
  static let identifier: String = "MovieSummaryTableViewCell"
  
  @IBOutlet private weak var movieImage: UIImageView!
  @IBOutlet private weak var title: UILabel!
  @IBOutlet private weak var releaseDate: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  static func getNib() -> UINib {
    let nib = UINib(nibName: identifier, bundle: nil)
    return nib
  }
  
  func setupCell(movieSummary: MovieSummary) {
    setCellImage(movieSummary)
    title.text = movieSummary.title
    releaseDate.text = movieSummary.releaseDate.formatted(date: .long, time: .omitted)
  }
  
  private func setCellImage(_ movieSummary: MovieSummary) {
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
