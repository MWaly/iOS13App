//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import EventsVIPER

class NetworkManagerTests: XCTestCase {
    
    func test_whenApplyingNetworkService_withResponseThatIsSnakeCased_thenDataGetsParsedCorrectly() {
        let networkManager = NetworkManager(session: URLSessionMock(path: .snakeCased), configuration: defaultNetworkConfiguration)
        
        let result: Result<[EventDTO]>? = assertNetworkManagerResponse(networkManager)
        switch result {
        case .success(let events)?:
            XCTAssertFalse(events.isEmpty)
            assertSnapshot(matching: result, as: .dump)
        default:
            XCTFail()
        }
    }
    
    func test_whenApplyingNetworkService_withResponseThatIsCamelCasedAndPassedArgument_thenDatareturnsParsingError() {
        
        let networkManager = NetworkManager(session: URLSessionMock(path: .camelCased), configuration: defaultNetworkConfiguration)
        
        let result: Result<[EventDTO]>? = assertNetworkManagerResponse(networkManager)
        switch result {
        case .failure(let error)?:
            let networkError = NetworkError.parsing
            XCTAssertTrue(error.localizedDescription == networkError.localizedDescription)
            assertSnapshot(matching: result, as: .dump)
        default:
            XCTFail()
        }
    }
    
}

private extension NetworkManagerTests {
    
    func assertNetworkManagerResponse(_ networkManager: NetworkManager) -> Result<[EventDTO]>? {
        
        let loadingEventsExpectation = self.expectation(description: "loadingEventsExpectation")
        var resultToReturn: Result<[EventDTO]>? = nil
        
        networkManager.loadEvents([NetworkRequestParameters.apiKey : "x"]) { result in
            
            loadingEventsExpectation.fulfill()
            resultToReturn = result
        }
        let _ = XCTWaiter.wait(for: [loadingEventsExpectation], timeout: 1.0)
        return resultToReturn
    }
    
}

