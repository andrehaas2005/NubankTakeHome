import Foundation
import Networking

final class NetworkClientMock: NetworkClientProtocol {

    enum Mode {
        case success(Decodable)
        case failure(Error)
    }

    // MARK: - Configuração do comportamento
    var mode: Mode = .success(EmptyResponse())
    
    // MARK: - Captura das chamadas
    private(set) var lastEndpoint: Endpoint?
    private(set) var lastBody: Encodable?
    
    // MARK: - POST
    func post<T, U>(_ endpoint: Endpoint, body: T) async throws -> U where T : Encodable, U : Decodable {
        lastEndpoint = endpoint
        lastBody = body

        switch mode {
        case .success(let any):
            guard let result = any as? U else {
                fatalError("Mock configurado com tipo errado. Esperado \(U.self), obtido \(type(of: any))")
            }
            return result

        case .failure(let error):
            throw error
        }
    }
    
    // MARK: - GET
    func get<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable {
        lastEndpoint = endpoint

        switch mode {
        case .success(let any):
            guard let result = any as? T else {
                fatalError("Mock configurado com tipo errado. Esperado \(T.self), obtido \(type(of: any))")
            }
            return result

        case .failure(let error):
            throw error
        }
    }
}

// Necessário para permitir sucesso padrão sem crash
private struct EmptyResponse: Decodable {}
