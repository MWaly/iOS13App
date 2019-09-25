//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import Foundation
import UIKit

//MARK: Interactor Protocols

protocol ListInteractorInput: class {
    var output: ListInteractorOutput? { get set }
    var events: [Event] { get set }
    
    func loadEvents()
}

protocol ListInteractorOutput: class {
    var numberOfEvents: Int { get }
    
    func loadedEvents(_ loadedCityEvents: [Event])
    func errorOccured(error: Error)
}

//MARK: Presenter Protocols

protocol ListPresenterInput: class {
    var interactor: ListInteractorInput { get set }
    var presenterOutput: ListPresenterOutput? { get set }
    var router: ListRouter? { get set }

    func toggleFavorite(atIndex index: Int)
    func loadEvents()
}

protocol ListPresenterOutput: class {
    var numberOfEvents: Int { get }
    var events: [Event]? { get set }
    
    func presentError(error: Error)
    func loadingStarted()
    func dataLoaded()
}


//MARK: Datasource Protocol

protocol ListDataManagerProtocol: class {
    func getEvents(result: @escaping (Result<[Event]>) -> Void)
    func setFavorite(_ newValue: Bool,_ id: String)
}



