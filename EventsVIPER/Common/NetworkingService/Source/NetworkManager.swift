//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    var session: URLSession { get }
    var builder: RequestBuilder { get set }
    var configuration: NetworkServiceConfigurable { get }
    
    func getArrayRequest<T: Decodable>(_ request: URLRequest,
                                       decodingStrategy: JSONDecoder.KeyDecodingStrategy,
                                       completion: @escaping (Result<[T]>) -> Void)
    func loadEvents(_ keywords: [NetworkRequestParameters: String], completion: @escaping (Result<[EventDTO]>) -> Void)

}

final class NetworkManager: NetworkManagerProtocol {

    let session: URLSession
    lazy var builder: RequestBuilder = RequestBuilder(configuration: configuration)
    let configuration: NetworkServiceConfigurable
    
    private static let defaultConfiguration = NetworkServiceConfigurator(baseUrl: Path.baseURL.rawValue, apiKey: DefaultValues.apiKey.rawValue)
    
    init(session: URLSession = URLSession.shared,
         configuration: NetworkServiceConfigurable = defaultConfiguration) {
        self.session = session
        self.configuration = configuration
    }
    
    func getArrayRequest<T: Decodable>(_ request: URLRequest,
                                       decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,  completion: @escaping (Result<[T]>) -> Void) {
        
        let task = session.dataTask(with: request) { [weak self]
            (data, response, error) in
            guard let self = self else { return }
            guard error == nil else {
                let errorToPass = self.evaluate(error: error)
                completion(.failure(error: errorToPass))
                return
            }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = decodingStrategy
        guard let responseData = data,
            let eventsObject = try? jsonDecoder.decode([T].self, from: responseData)
            else {
                completion(.failure(error: NetworkError.parsing))
                return
            }
            completion(Result.success(value: eventsObject))
        }
        task.resume()
    }
}

// MARK: Helpers

extension NetworkManager {
    
    private func evaluate(error: Error?) -> NetworkError {
        //TODO: Handle more error cases
        guard let _ = error else { return .unknown }
        return .generic
    }
    
    private func formatExtraParams(_ extraParams: [NetworkRequestParameters: String]) -> String {
        return extraParams.reduce("?") { arg0, arg1 in
            arg0 + arg1.key.rawValue + "=" + arg1.value
        }
    }
}
