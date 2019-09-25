//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import Foundation

protocol NetworkServiceConfigurable {
    var baseUrl: String { get }
    var apiKey: String? { get }
}

struct NetworkServiceConfigurator: NetworkServiceConfigurable {
    let baseUrl: String
    
    private(set) var apiKey: String?
    
    init(baseUrl: String, apiKey: String?) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
    
}
