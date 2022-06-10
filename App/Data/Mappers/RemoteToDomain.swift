import Foundation

extension Array where Element == MovieSummaryRM {
    func toDM() -> [MovieSummary] {
        map { movieSummaryRM in
            MovieSummary(
                id: movieSummaryRM.id,
                title: movieSummaryRM.title,
                posterUrl: movieSummaryRM.posterUrl,
                releaseDate: movieSummaryRM.releaseDate
            )
        }
    }
}

extension MovieDetailRM {
    func toDM() -> MovieDetail {
        return MovieDetail(
            id: id,
            backdropUrl: backdropUrl,
            title: title,
            voteAverage: voteAverage,
            runtime: runtime,
            genres: genres,
            releaseDate: releaseDate,
            budget: budget,
            overview: overview
        )
    }
}
