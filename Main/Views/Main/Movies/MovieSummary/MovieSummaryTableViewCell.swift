//
//  MovieSummaryTableViewCell.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import Kingfisher
import Domain
import Presentation

class MovieSummaryTableViewCell: UITableViewCell {
  // MARK: - IBOutlets
  @IBOutlet private weak var movieImage: UIImageView!
  @IBOutlet private weak var title: UILabel!
  @IBOutlet private weak var releaseDate: UILabel!

  // MARK: - Methods
  func configure(with movieSummary: MovieSummaryViewModel) {
    movieImage.contentMode = .scaleAspectFit
    title.text = movieSummary.title
    releaseDate.text = movieSummary.releaseDate
    movieImage.setImageFrom(
      url: movieSummary.imageUrl,
      placeholderImage: UIImage(systemName: "film")
    ) { [unowned self] _ in
      movieImage.contentMode = .scaleToFill
    }
  }
}