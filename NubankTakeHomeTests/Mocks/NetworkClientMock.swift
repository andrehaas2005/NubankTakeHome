import Foundation
import Networking

final class NetworkClientMock: NetworkClientProtocol {
  
  // MARK: - POST mock storage
  var receivedPostPath: String?
  var receivedPostBody: [String : Any]?
  var postResult: Decodable?
  var postError: Error?
  
  func post<T, U>(_ path: String, body: U) async throws -> T where T : Decodable, U : Encodable {
    receivedPostPath = path
    receivedPostBody = encodeToDictionary(body)
    
    if let postError = postError {
      throw postError
    }
    
    return postResult as! T
  }
  
  // MARK: - GET mock storage
  var receivedGetPath: String?
  var getResult: Decodable?
  var getError: Error?
  
  func get<T>(_ path: String) async throws -> T where T : Decodable {
    receivedGetPath = path
    
    if let getError = getError {
      throw getError
    }
    
    return getResult as! T
  }
  
  // Helper: transforma body em dicionário para verificação
  private func encodeToDictionary(_ encodable: Encodable) -> [String: Any]? {
    let encoder = JSONEncoder()
    guard let data = try? encoder.encode(AnyEncodable(encodable)),
          let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    else { return nil }
    
    return json
  }
}

/// Wrapper para permitir encode genérico de Encodable
private struct AnyEncodable: Encodable {
  private let encodable: Encodable
  
  init(_ encodable: Encodable) {
    self.encodable = encodable
  }
  
  func encode(to encoder: Encoder) throws {
    try encodable.encode(to: encoder)
  }
}
