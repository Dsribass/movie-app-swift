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
