//
//  Copyright © 2010 Mohamed Waly. All rights reserved.
//
//  Responsible for fetching the data from the Network [can be extended to cache or other data source]


import Foundation

final class ListDataManager: ListDataManagerProtocol {
    private let networkService: NetworkManagerProtocol
    private var localStore: LocalStorable
    
    init(networkService: NetworkManagerProtocol = NetworkManager(), localStore: LocalStorable = LocalStore()) {
        self.networkService = networkService
        self.localStore = localStore
    }
    
    func getEvents(result: @escaping (Result<[Event]>) -> Void) {
        networkService.loadEvents([.text : "Berlin"]) { [weak self] resultDTO in
            switch resultDTO {
            case .success(let events):
                let mappedEvents = events.map {
                    Event(id: $0.id,
                          name: $0.name,
                          localDate: $0.localDate,
                          localTime: $0.localTime,
                          yesRsvpCount: $0.yesRsvpCount,
                          groupName: $0.group.name,
                          favoriteStatus: self?.localStore.get(key: $0.id) ?? false)
                }
                result(.success(value: mappedEvents))
            case .failure(let error):
                result(.failure(error: NetworkError.generic))
            }
        }
    }
    
    func setFavorite(_ newValue: Bool, _ id: String) {
        if newValue {
            localStore.set(key: id, value: newValue)
        } else {
            localStore.remove(key: id)
        }
    }
    
}
