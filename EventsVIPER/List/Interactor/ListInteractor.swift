//
//  ListInteractor.swift
//  EventsVIPER
//
//  Created by Mokhles on 11.03.19.
//  Copyright © 2019 iostldr. All rights reserved.
//

import Foundation

final class ListInteractor: ListInteractorInput {
    
    
    private let dataManager: ListDataManagerProtocol
    weak var output: ListInteractorOutput?
    
    var events: [Event] = []
    
    init(_ dataManager: ListDataManagerProtocol = ListDataManager()) {
        self.dataManager = dataManager
    }
    
    func loadEvents() {
        self.dataManager.getEvents { [weak self] result in
            switch result {
            case .success(let events):
                self?.events = events
                self?.output?.loadedEvents(events)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

