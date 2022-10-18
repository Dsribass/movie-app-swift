import Foundation
import Moya

enum MovieProvider {
  case getMovieSummaryList
  case getMovieDetail(id: Int)
}

extension MovieProvider: TargetType {
  var baseURL: URL {
    return URL(string: "https://desafio-mobile.nyc3.digitaloceanspaces.com")!
  }

  var path: String {
    switch self {
    case .getMovieSummaryList: return "/movies"
    case .getMovieDetail(let id): return "/movies/\(id)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getMovieSummaryList: return .get
    case .getMovieDetail: return .get
    }
  }

  var task: Task {
    return .requestPlain
  }

  var headers: [String: String]? {
    return nil
  }
}
