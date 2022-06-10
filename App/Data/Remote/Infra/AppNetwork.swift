import Foundation

class AppNetwork {
    public func request<S>(urlString: String) async -> Result<S,AppError> where S: Decodable {
        let url = URL(string: urlString)!
        
        let response = try? await URLSession.shared.data(from: url)
        let statusCode = (response?.1 as? HTTPURLResponse)?.statusCode
        
        if statusCode != 200 {
            return .failure(.requestError)
        }
        
        guard let data = response?.0 else {
            return .failure(.requestError)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try decoder.decode(S.self, from: data)
            return .success(result)
        } catch {
            return .failure(.decodingError)
        }
    }
}
