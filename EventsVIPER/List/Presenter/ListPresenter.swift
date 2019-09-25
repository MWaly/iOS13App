//
//  ListPresenter.swift
//  EventsVIPER
//
//  Created by Mokhles on 11.03.19.
//  Copyright © 2019 iostldr. All rights reserved.
//

import Foundation

final class ListPresenter: ListPresenterInput, ListInteractorOutput {
    var interactor: ListInteractorInput
    
    var numberOfEvents: Int = 0
    
    func loadedEvents(_ loadedCityEvents: [Event]) {
        self.numberOfEvents = loadedCityEvents.count
        self.presenterOutput?.events = loadedCityEvents
        self.presenterOutput?.dataLoaded()
    }
    
    func errorOccured(error: Error) {
        
    }
    

    weak var presenterOutput: ListPresenterOutput?
    var router: ListRouter?

    init(interactor: ListInteractorInput) {
        self.interactor = interactor
        self.interactor.output = self
    }
    
    func loadEvents() {
        interactor.loadEvents()
    }

    
    func toggleFavorite(atIndex index: Int) {
        
    }
}
