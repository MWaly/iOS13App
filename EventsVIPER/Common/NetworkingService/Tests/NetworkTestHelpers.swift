//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import Foundation
@testable import EventsVIPER

let defaultNetworkConfiguration = MockDefaultNetworkConfiguration()

final class MockDefaultNetworkConfiguration: NetworkServiceConfigurable {
    var baseUrl: String = Path.baseURL.rawValue
    var apiKey: String? = DefaultValues.apiKey.rawValue
}


enum MockFilePath: String {
    case snakeCased = "ListManagerMockResponse"
    case camelCased = "ListingResponseCamelCased"
    case errorParsed = "ListingFailResponse"
}

/// Helper classes for mocks [inspired from Jon Sundell]

final class URLSessionMock: URLSession {
    
    var data: Data?
    var error: Error?
    let path: String
    
    init(path: MockFilePath) {
        self.path = Bundle.main.path(forResource: path.rawValue, ofType: "json") ?? ""
        self.data = try? Data(contentsOf: URL(fileURLWithPath: self.path), options: .mappedIfSafe)
        super.init()
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}

final class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
    
}
