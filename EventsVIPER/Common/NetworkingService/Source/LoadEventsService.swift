//
//  LoadEventsService.swift
//  EventsVIPER
//
//  Created by Waly, Mohamed(AWF) on 15.03.19.
//  Copyright © 2019 iostldr. All rights reserved.
//

import Foundation

protocol LoadEventsServiceProtocol {
     func loadEvents(_ keywords: [NetworkRequestParameters: String], completion: @escaping (Result<[EventDTO]>) -> Void)
}

final class LoadEventsService: LoadEventsServiceProtocol {

    var networkManager: NetworkManagerProtocol
    
    func loadEvents(_ keywords: [NetworkRequestParameters: String], completion: @escaping (Result<[EventDTO]>) -> Void) {
        guard let request = builder.setupAutheticatedGetRequest(for: .findEvents, formattedExtraParams: formatExtraParams(keywords)) else { return }
        getArrayRequest(request, completion: completion)
    }
    
    
}
