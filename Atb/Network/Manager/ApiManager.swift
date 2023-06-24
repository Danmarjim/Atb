import Combine
import Foundation

enum NetworkError: Error {
  case invalidResponse
  case decodingError
}

protocol APIManager {
  var baseURL: String { get }
  var session: URLSession { get }
  var requestMethod: String { get }
}
