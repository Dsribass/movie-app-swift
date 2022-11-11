import Foundation
import Moya

public enum MovieProvider {
  case getMovieSummaryList
  case getMovieDetail(id: Int)
}

extension MovieProvider: TargetType {
  public var baseURL: URL {
    return URL(string: "https://api.themoviedb.org/3")!
  }

  public var token: String {
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZjZmMTQ5MjMyMzZkNmExMGZiNGE0NzcwNDM0MjM3MyIsInN1YiI6IjYzNmUyMzdiY2E0ZjY3MDA5YjU0Mjg1YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nMRr7iWy6wN-ehxVlfjFlrV8nzn6nlxS-y0XM-qxx00"
  }

  public var path: String {
    switch self {
    case .getMovieSummaryList: return "/movie/popular"
    case .getMovieDetail(let id): return "/movie/\(id)"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .getMovieSummaryList: return .get
    case .getMovieDetail: return .get
    }
  }

  public var task: Task {
    return .requestParameters(parameters: ["language":"pt-BR"], encoding: URLEncoding.queryString)
  }

  public var headers: [String: String]? {
    return [
      "Content-type": "application/json",
      "Authorization": "Bearer \(token)"
    ]
  }
}
