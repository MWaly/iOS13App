//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import EventsVIPER

class NetworkRequestTests: XCTestCase {

    func test_givenDefaultValues_whenPassingToGetRequestBuilder_thenRequestinitilaizedCorrectly() {
        let requestBuilder = RequestBuilder(configuration: defaultNetworkConfiguration)
        let request = requestBuilder.setupAutheticatedGetRequest(for: Path.findEvents, formattedExtraParams: "?extra1")
        XCTAssertTrue(request?.url?.absoluteString.contains(DefaultValues.apiKey.rawValue) ?? false)
        assertSnapshot(matching: request, as: .dump)
    }
    
    func test_whenSettingUpAuthenticatedGetRequest_withPassingCustomAPIKey_thenAPIKeyGetsInjectedCorrectly() {
        let requestBuilder = RequestBuilder(configuration: NetworkServiceConfigurator(baseUrl: Path.baseURL.rawValue, apiKey: "APIKEY"))
        let request = mockUrlRequest(requestBuilder)
        
        XCTAssertTrue(request?.url?.absoluteString.contains("APIKEY") ?? false)
        assertSnapshot(matching: request, as: .dump)
    }
    
    func test_whenSettingUpAuthenticatedGetRequest_withPassingNilAPIKey_thenRequestNotCreated() {
        
        let requestBuilder = RequestBuilder(configuration: NetworkServiceConfigurator(baseUrl: Path.baseURL.rawValue, apiKey: nil))
        let request = mockUrlRequest(requestBuilder)
        
        XCTAssertNil(request)
        assertSnapshot(matching: request, as: .dump)
    }
    
}

private extension NetworkRequestTests {
    
    func mockUrlRequest(_ requestBuilder: RequestBuilder) -> URLRequest? {
        return requestBuilder.setupAutheticatedGetRequest(for: Path.findEvents, formattedExtraParams: "?extra=1&extra2=2")
    }
    
}
