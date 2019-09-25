//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import Foundation

protocol RequestBuildable {
    func buildGetRequest(_ url: URL) -> URLRequest?
    func setupAutheticatedGetRequest(for path: Path, formattedExtraParams: String) -> URLRequest?
}

final class RequestBuilder: RequestBuildable {

    private let configuration: NetworkServiceConfigurable
    
    init(configuration: NetworkServiceConfigurable) {
        self.configuration = configuration
    }
    
    //TODO: invoke api team about important headers to be included

    func buildGetRequest(_ url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    func setupAutheticatedGetRequest(for path: Path, formattedExtraParams: String) -> URLRequest? {
        guard let apiKey = configuration.apiKey,
            let url = URL(string: configuration.baseUrl + Path.findEvents.rawValue + formattedExtraParams + formattedAPIKey(apiKey)) else {
            return nil
        }
        return buildGetRequest(url)
    }

    //TODO: refactor to format & join multiple parameters
    private func formattedAPIKey(_ key: String) -> String {
        return "&" + NetworkRequestParameters.apiKey.rawValue + "=" + key
    }
    
    
}
