//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import XCTest
@testable import EventsVIPER

class LocalStorageTests: XCTestCase {
    
    var sharedStore = LocalStore(store: UserDefaults.makeClearedInstance())
    
    func test_WhenAddingAFavorite_GivenItAlreadyExists_ThenItRemainsInStore(){
        var store = createEmptyStore()
        
        store.set(key: "a", value: true)
        XCTAssertNotNil(store.get(key: "a"))
        XCTAssertTrue(store.get(key: "a")!)
        
        store.set(key: "a", value: true)
        XCTAssertNotNil(store.get(key: "a"))
        XCTAssertTrue(store.get(key: "a")!)
    }
    
    func test_WhenAddingAFavorite_GivenItDoesntExist_ThenItIsAddedToStore(){
        var store = createEmptyStore()
        
        store.set(key: "a", value: true)
        XCTAssertNotNil(store.get(key: "a"))
        XCTAssertTrue(store.get(key: "a")!)
    }
    
    func test_WhenRemovingAFavorite_GivenItAlreadyExists_ThenItIsDeleted(){
        sharedStore.set(key: "favoriteA", value: true)
        XCTAssertNotNil(sharedStore.get(key: "favoriteA"))
        
        sharedStore.remove(key: "favoriteA")
        XCTAssertNil(sharedStore.get(key: "favoriteA"))
    }
    
    func test_WhenRemovingAFavorite_GivenItAlreadyDoesntExists_ThenNothingHappens(){
        var store = createEmptyStore()
        XCTAssertNil(store.get(key: "favoriteA"))
        XCTAssertNil(store.get(key: "favoriteB"))
        
        store.remove(key: "favoriteA")
        store.remove(key: "favoriteB")
        
        XCTAssertNil(store.get(key: "favoriteA"))
        XCTAssertNil(store.get(key: "favoriteB"))
    }
    
    func test_WhenCreatingMultipleStore_GivenThatTheyHaveDifferentKeys_ValuesDoNotMix() {
        var store = LocalStore(store: UserDefaults.makeClearedInstance(),
            currentKey: StoreKey(name: "TestingKey"))
        
        store.set(key: #function, value: true)
        XCTAssertNotNil(store.get(key: #function))
        XCTAssertTrue(store.get(key: #function)!)
        
        XCTAssertNil(sharedStore.get(key: #function))
    }
    
    private func createEmptyStore() -> LocalStore {
        return LocalStore(store: UserDefaults.makeClearedInstance())
    }
    
}

//Helper method for clear store, inspured by JON SUNDELL

extension UserDefaults {
    
    static func makeClearedInstance(
        for functionName: StaticString = #function,
        inFile fileName: StaticString = #file
        ) -> UserDefaults {
        let className = "\(fileName)".split(separator: ".")[0]
        let testName = "\(functionName)".split(separator: "(")[0]
        let suiteName = "com.waly.\(className).\(testName)"
        
        let defaults = self.init(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }
    
}
