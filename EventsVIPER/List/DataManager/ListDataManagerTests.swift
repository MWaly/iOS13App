//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import XCTest
@testable import EventsVIPER

class ListDataManagerTests: XCTestCase {
    
    func test_WhenLoadingEventsFromNetwork_GivenSuccessfulResponse_ThenMappedCorrectly(){
        let dataManager = ListDataManager(networkService: MockNetworkManager(), localStore: LocalStore())
    }
    
    func test_WhenLoadingEventsFromNetwork_GivenFailResponse_ThenErrorFired(){
        XCTFail()
    }
    
    func test_WhenLoadingEventsFromNetwork_GivenSuccessfulResponseAndPreviouslyFavoritedItems_ThenMappedCorrectlyWithCorrectFavoriteStatus(){
        XCTFail()
    }
    
    func test_WhenTogglingFavorite_GivenSuccessfulResponse_ThenMappedCorrectlyInStore(){
        XCTFail()
    }
    
}


final class MockNetworkManager: NetworkManagerProtocol {
    
    func getArrayRequest<T: Decodable>(_ request: URLRequest, decodingStrategy: JSONDecoder.KeyDecodingStrategy, completion: @escaping (Result<[T]>) -> Void) {
        
        let eventsObject = [EventDTO(id: "id",
                                     name: "name",
                                     localDate: "localDate",
                                     localTime: "LocalTime",
                                     yesRsvpCount: 5,
                                     group: Group(name: "group"))]
        
        completion(Result.success(value: eventsObject))
    }
    
    var session: URLSession = URLSession.shared
    var configuration: NetworkServiceConfigurable = NetworkServiceConfigurator(baseUrl: "url", apiKey: nil)
    lazy var builder: RequestBuilder = RequestBuilder(configuration: configuration)
}
