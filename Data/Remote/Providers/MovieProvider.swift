import Foundation
import Moya

public enum MovieProvider {
  case getMovieSummaryList
  case getMovieDetail(id: Int)
}

extension MovieProvider: TargetType {
  public var baseURL: URL {
    return URL(string: "https://desafio-mobile.nyc3.digitaloceanspaces.com")!
  }

  public var path: String {
    switch self {
    case .getMovieSummaryList: return "/movies"
    case .getMovieDetail(let id): return "/movies/\(id)"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .getMovieSummaryList: return .get
    case .getMovieDetail: return .get
    }
  }

  public var task: Task {
    return .requestPlain
  }

  public var headers: [String: String]? {
    return nil
  }
}
