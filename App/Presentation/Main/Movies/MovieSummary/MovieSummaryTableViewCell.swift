//
//  MovieSummaryTableViewCell.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import Kingfisher

class MovieSummaryTableViewCell: UITableViewCell {
  // MARK: - Initializers
  init(movieSummary: MovieSummary, style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell(movieSummary: movieSummary)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  // MARK: - IBOutlets
  @IBOutlet private weak var movieImage: UIImageView!
  @IBOutlet private weak var title: UILabel!
  @IBOutlet private weak var releaseDate: UILabel!

  // MARK: - View Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - Methods
  func setupCell(movieSummary: MovieSummary) {
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
        options: [.transition(.fade(0.2))])
    } else {
      self.movieImage.image = image
    }
  }
}
