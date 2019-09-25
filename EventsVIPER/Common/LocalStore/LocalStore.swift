//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import Foundation


struct StoreKey  {
    let name: String
    
    init(name: String = "simpleStore") {
        self.name = name
    }
}

protocol LocalStorable {
    var store: UserDefaults { get }
    var currentKey: StoreKey { get }
    var currentStoreEnteries: [String: Bool] { get set }
    
    func get(key: String) -> Bool?
    mutating func remove(key: String)
    mutating func set(key: String, value: Bool)
}

extension LocalStorable {
    
    func get(key: String) -> Bool? {
        return currentStoreEnteries[key]
    }
    
    mutating func set(key: String, value: Bool) {
        currentStoreEnteries[key] = value
        updateLocalStore()
    }
    
    mutating func remove(key: String) {
        currentStoreEnteries.removeValue(forKey: key)
        updateLocalStore()
    }
    
    private func updateLocalStore() {
        store.set(currentStoreEnteries, forKey: currentKey.name)
    }
    
}

final class LocalStore: LocalStorable {
    
    let store: UserDefaults
    let currentKey: StoreKey
    
    lazy var currentStoreEnteries: [String: Bool] =
    store.dictionary(forKey: currentKey.name) as? [String: Bool] ?? [String: Bool]()
    
    init(store: UserDefaults = UserDefaults.standard,
         currentKey: StoreKey = StoreKey()) {
        self.store = store
        self.currentKey = currentKey
    }

}
