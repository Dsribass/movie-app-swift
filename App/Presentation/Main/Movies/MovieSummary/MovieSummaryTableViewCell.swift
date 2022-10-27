//
//  MovieSummaryTableViewCell.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import Kingfisher

class MovieSummaryTableViewCell: UITableViewCell {
  // MARK: - IBOutlets
  @IBOutlet private weak var movieImage: UIImageView!
  @IBOutlet private weak var title: UILabel!
  @IBOutlet private weak var releaseDate: UILabel!

  // MARK: - Methods
  func configure(with movieSummary: MovieSummary) {
    movieImage.contentMode = .scaleAspectFit
    setCellImage(movieSummary)
    title.text = movieSummary.title
    releaseDate.text = movieSummary.releaseDate.formatted(date: .long, time: .omitted)
  }

  private func setCellImage(_ movieSummary: MovieSummary) {
    let image = UIImage(systemName: "film")

    if let url = URL(string: movieSummary.posterUrl) {
      self.movieImage.kf.setImage(
        with: url,
        placeholder: image,
        options: [.transition(.fade(0.2))]) { [unowned self] result in
          if (try? result.get()) != nil {
            movieImage.contentMode = .scaleToFill
          }
      }
    } else {
      self.movieImage.image = image
    }
  }
}
